require 'rails_helper'
require "browser"

describe SharedLinksController do
  describe 'GET #share' do
    context 'iOS device' do
      let(:params) do
        { param: Faker::Lorem.word }
      end

      before do
        browser = Browser.new('iPhone')
        allow(subject).to receive(:browser).and_return(browser)
        get :share, params
      end

      it 'should render share_path' do
        should render_template('share')
      end

      it 'should render assigns link to @link' do
        expected_link = "#{SharedLinksController::APP_PROTOCOL}://share?#{request.query_string}"
        expect(assigns(:link)).to eq(expected_link)
      end
    end

    context 'not iOs device' do
      it 'redirects to root_path' do
        get :share
        should redirect_to(root_path)
      end
    end
  end
end
