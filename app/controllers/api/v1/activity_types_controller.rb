# frozen_string_literal: true

class Api::V1::ActivityTypesController < ApplicationController
  def create
    number = params[:number]
    activity_type = ActivityType.create(activity_type: params[:activity_type], trip_id: params[:trip])

    if activity_type.persisted?
      activities = Activity.create_activities(activity_type, number)

      if activities && activities.length == number.to_i
        render json: activities, status: 200
      else
        activity_type.destroy
        render json: { error: 'Failed to create activity.' }, status: 422
      end
    else
      render json: { error: activity_type.errors.full_messages }, status: 422
    end
  end
end