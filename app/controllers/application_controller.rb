# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # render the response based on success
  def render_json(result)
    if result.success?
      render(json: { success: result.success?, response: result.response, errors: result.errors })
    else
      render(json: { success: result.success?, response: result.response, errors: result.errors }, status: 405)
    end
  end
end
