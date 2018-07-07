# frozen_string_literal: true

module Remote
  # This class defines resources exposed via the REST API and actions
  # associated with those resources.
  class API < Grape::API
    version 'v1', using: :header, vendor: 'remote'
    format :json
    prefix :api

    resource :aquos do
      desc 'Send Aquos remote signal.'
      params do
        requires :signal, type: String, desc: 'Remote signal'
      end
      put ':signal' do
        system("irsend SEND_ONCE aquos #{params[:signal]}")
      end
    end

    resource :bluray do
      desc 'Send Bluray remote signal.'
      params do
        requires :signal, type: String, desc: 'Remote signal'
      end
      put ':signal' do
        signal = params[:signal]
        if %w[volup voldown].include?(signal)
          system("irsend SEND_ONCE aquos #{signal}")
        else
          system("irsend SEND_ONCE bluray #{signal}")
        end
      end
    end
  end
end
