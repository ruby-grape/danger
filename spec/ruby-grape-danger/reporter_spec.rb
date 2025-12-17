require 'spec_helper'
require 'json'
require 'tempfile'

RSpec.describe RubyGrapeDanger::Reporter do
  let(:status_report) do
    {
      errors: ['Error 1', 'Error 2'],
      warnings: ['Warning 1'],
      messages: ['Message 1', 'Message 2'],
      markdowns: ['## Markdown 1']
    }
  end

  let(:event_json) do
    {
      'pull_request' => {
        'number' => 42
      }
    }
  end

  let(:reporter) { RubyGrapeDanger::Reporter.new(status_report) }

  describe '#initialize' do
    it 'stores the status_report' do
      expect(reporter.instance_variable_get(:@status_report)).to eq(status_report)
    end
  end

  describe '#export_json' do
    let(:report_file) { Tempfile.new('danger_report.json') }
    let(:event_file) { Tempfile.new('event.json') }

    before do
      event_file.write(JSON.generate(event_json))
      event_file.close
    end

    after do
      report_file.unlink
      event_file.unlink
    end

    it 'creates a JSON report with all fields' do
      reporter.export_json(report_file.path, event_file.path)

      report = JSON.parse(File.read(report_file.path))
      expect(report['pr_number']).to eq(42)
      expect(report['errors']).to eq(['Error 1', 'Error 2'])
      expect(report['warnings']).to eq(['Warning 1'])
      expect(report['messages']).to eq(['Message 1', 'Message 2'])
      expect(report['markdowns']).to eq(['## Markdown 1'])
    end

    it 'formats the JSON nicely (pretty printed)' do
      reporter.export_json(report_file.path, event_file.path)

      content = File.read(report_file.path)
      expect(content).to include("\n")
      expect(content).to include("  ")
    end

    context 'with message objects (not strings)' do
      let(:status_report) do
        error_obj = double('error', message: 'Object error')
        warning_obj = double('warning', message: 'Object warning')

        {
          errors: [error_obj],
          warnings: [warning_obj],
          messages: [],
          markdowns: []
        }
      end

      it 'converts objects with message method to strings' do
        reporter.export_json(report_file.path, event_file.path)

        report = JSON.parse(File.read(report_file.path))
        expect(report['errors']).to eq(['Object error'])
        expect(report['warnings']).to eq(['Object warning'])
      end
    end

    context 'with mixed message types' do
      let(:status_report) do
        obj = double('mixed', message: 'Object message')

        {
          errors: ['String error', obj],
          warnings: [],
          messages: [],
          markdowns: []
        }
      end

      it 'handles both strings and objects' do
        reporter.export_json(report_file.path, event_file.path)

        report = JSON.parse(File.read(report_file.path))
        expect(report['errors']).to eq(['String error', 'Object message'])
      end
    end

    context 'with empty arrays' do
      let(:status_report) do
        {
          errors: [],
          warnings: [],
          messages: [],
          markdowns: []
        }
      end

      it 'creates report with empty arrays' do
        reporter.export_json(report_file.path, event_file.path)

        report = JSON.parse(File.read(report_file.path))
        expect(report['errors']).to eq([])
        expect(report['warnings']).to eq([])
        expect(report['messages']).to eq([])
        expect(report['markdowns']).to eq([])
      end
    end

    context 'with nil values' do
      let(:status_report) do
        {
          errors: nil,
          warnings: nil,
          messages: nil,
          markdowns: nil
        }
      end

      it 'converts nil to empty array' do
        reporter.export_json(report_file.path, event_file.path)

        report = JSON.parse(File.read(report_file.path))
        expect(report['errors']).to eq([])
        expect(report['warnings']).to eq([])
        expect(report['messages']).to eq([])
        expect(report['markdowns']).to eq([])
      end
    end

    context 'when report_path is nil' do
      it 'does not create a file' do
        reporter.export_json(nil, event_file.path)

        # If file was created, we would have a different path
        expect(File.exist?(report_file.path)).to be true
      end
    end

    context 'when event_path is nil' do
      it 'does not create a file' do
        reporter.export_json(report_file.path, nil)

        expect(File.size(report_file.path)).to eq(0)
      end
    end

    context 'when event file does not exist' do
      it 'does not create a report file' do
        reporter.export_json(report_file.path, '/nonexistent/path/event.json')

        expect(File.size(report_file.path)).to eq(0)
      end
    end

    context 'when event has no pull_request.number' do
      let(:event_json) do
        {
          'pull_request' => {}
        }
      end

      it 'does not create a report file' do
        reporter.export_json(report_file.path, event_file.path)

        expect(File.size(report_file.path)).to eq(0)
      end
    end

    context 'when event has no pull_request key' do
      let(:event_json) do
        {}
      end

      it 'does not create a report file' do
        reporter.export_json(report_file.path, event_file.path)

        expect(File.size(report_file.path)).to eq(0)
      end
    end

    context 'with multiline markdown' do
      let(:status_report) do
        {
          errors: [],
          warnings: [],
          messages: [],
          markdowns: ["## Details\n\nSome content"]
        }
      end

      it 'preserves multiline markdown' do
        reporter.export_json(report_file.path, event_file.path)

        report = JSON.parse(File.read(report_file.path))
        expect(report['markdowns']).to eq(["## Details\n\nSome content"])
      end
    end
  end
end
