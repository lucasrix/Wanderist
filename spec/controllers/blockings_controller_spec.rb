require 'rails_helper'

describe BlockingsController do
  before do
    allow(ReportEmailJob).to receive(:perform_later)
    request.env["HTTP_REFERER"] = Faker::Internet.url
  end

  shared_examples 'blockings' do |reportable|
    let!(:resource) { create(reportable) }
    let!(:report) { create(:report, reportable: resource) }
    let :params do
      {
        action_token: report.action_token,
        report_id: report.id
      }
    end

    describe 'GET #edit' do
      context 'bad action_token' do
        it 'renders 404' do
          params[:action_token] = Faker::Lorem.characters(32)
          put :edit, params
          expect(response).to render_template(file: "404.html")
        end
      end

      it 'render edit template' do
        get :edit, params
        expect(response).to render_template(:edit)
      end
    end

    describe 'PUT #update' do
      context 'bad action_token' do
        it 'renders 404' do
          params[:action_token] = Faker::Lorem.characters(32)
          put :update, params
          expect(response).to render_template(file: "404.html")
        end
      end

      context 'make blocked truthy' do
        before  do
          params[:blocked] = true
        end

        it 'makes blocked truthy' do
          put :update, params
          resource.reload
          status = resource.blocked
          expect(status).to be_truthy
        end
      end

      context 'makes blocked falsey' do
        before  do
          resource.update(blocked: true)
          resource.reload
          params[:blocked] = false
        end

        it 'makes blocked falsey' do
          put :update, params
          resource.reload
          status = resource.blocked
          expect(status).to be_falsey
        end
      end

      it 'redirects to back' do
        put :update, params
        expect(response).to redirect_to(:back)
      end
    end
  end


  context 'blockings story' do
    it_behaves_like 'blockings', :story
  end

  context 'blockings story_point' do
    it_behaves_like 'blockings', :story_point
  end
end
