require 'rails_helper'

describe Api::V1::ReportsController do
  let!(:story) { create(:story_with_story_points) }
  let!(:story_point) { create(:story_point) }

  include_context 'ability'

  before do
    allow(ReportEmailJob).to receive(:perform_later)
  end

  shared_examples 'create_report' do
    it 'should be success', :show_in_doc do
      post :create, params
      should respond_with :created
    end

    it 'should create a report' do
      expect { post :create, params }.to change { Report.count }.by(1)
    end

    it 'should return status 422' do
      allow_any_instance_of(Report).to receive(:save).and_return(false)
      post :create, params
      should respond_with :unprocessable_entity
    end
  end

  describe 'POST #create' do
    context 'report for story' do
      let(:params) do
        { story_id: story.id, kind: Report::REPORT_KIND.sample }
      end

      it_behaves_like 'create_report'
    end

    context 'report for story_point' do
      let(:params) do
        { story_point_id: story_point.id, kind: Report::REPORT_KIND.sample }
      end

      it_behaves_like 'create_report'
    end
  end

  context 'unauthorized' do
    let(:params) do
      { story_id: story.id, kind: Report::REPORT_KIND.sample }
    end

    it 'should return status 403', :show_in_doc do
      ability.cannot :create, Report
      reload_ability(ability)
      post :create, params
      should respond_with :forbidden
    end
  end
end
