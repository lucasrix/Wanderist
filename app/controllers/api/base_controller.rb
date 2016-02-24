class Api::BaseController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

end
