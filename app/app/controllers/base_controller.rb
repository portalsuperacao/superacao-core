class BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :destroy_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  def api_error(status: 500, errors: [])
     unless Rails.env.production?
       puts errors.full_messages if errors.respond_to? :full_messages
     end
     head status: status and return if errors.empty?

     render json: errors, status: status
  end

  private
    def authenticate(options = {skip_user_load:false})
      begin
        jwt_token = read_token

        raise 'Token not provided' if jwt_token.chop.empty?

        decoded_token = decode_token(jwt_token)
        @uid = decoded_token[:sub]
        
        unless options[:skip_user_load]
          participant = Participant.find_by_uid(@uid)
          if !participant
            raise "Participant not found for uid: #{uid}"
          else
            @current_user = participant
          end
        end

      rescue Exception => e
        logger.error("Failed to verify jwt due to: '#{e.message}'")
        api_error(status: 401)
      end
    end

    def firebase_public_key
      public_keys = {
       "cdb68f905a61dfd6413e5b187eb6880bfe79b44b" => "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIdcJCKAA+qGAwDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTYw\nODIxMDA0NTI2WhcNMTYwODI0MDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBANWpFx+BVQp6+cGpfU9o0ZBQV0nDmi6NQHxQvryPldCfrZ2u\nhwGRZAqjRinLa7byzep0ljPpqLBj3bwB6mCWqGxch3MQjGw4p+WVvNH7SBLHjUtK\nIXL3104ymEOqbTx4XpIB59QuC8D5f+11H6Ljf3nSslaJl1W2/oGw6YNySYNUoCuj\nrvxF1CM/soRpJEMYIvU6zGXdRpK47rXCg05cpEkEf3FIohGcHM0LXiE5JtrNz/b/\n8x0/60xuYLPxDwZdMEHFBzxIRDQ1Jq9jt5xGYt5LafZCvndpJHVKz7RmPiXK6a+6\nTPtraBwK83N4WAAN+BAaGwKkYiqBblsexE8XKLsCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBAFzA+uVlXwnQDLopRfHq0JcUVYhKdpXi+txM212NrD8g\n9u84k1rMQkn+6eR+4FOVqQjyyeFHxyBkHi2lpdAQs8qYxKfxe9/t1Xs7X0MyJbMJ\nvle4fP1d1vJprGTCmt1e+BCZ8zs2xHvRty6O/6k9ScgrvSLhH8h/jgbtFTFKViLY\nDc7XeoSc3khRaJqsZVqY4hfTguDcoxq91y4MzCXYKLNDoQW75awhTE7MZ39UgBVV\nZt2tv8ob9/KiOU5UXAnTm7xQsbUkRLYBZaT3QKs8yAWduJvGadGfmOPtQwOn7OTC\nhkZA89dWWl8lMuBXhdOidTDXi6DoHxWCpaVIg1+D3JQ=\n-----END CERTIFICATE-----\n",
       "c7ff524ed7e72684efc0aae442f8b58a93e12869" => "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIXM18ft/jmRAwDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTYw\nODE5MDA0NTI2WhcNMTYwODIyMDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAKqU/fGvr0DZObp1JJ/19bCpENVOmpO3/FBLDGHXi2bZJuYu\nVxgsP+aLZ+NqXOMbix0NuUJT/DDWW3/ZDrFEuzFiXliJQ/rOljOk13rTWLN1Z4fh\naiJv+FB8LDXcPbhWV02Wr7RisUPZvQjG3nDYa8OOboGWZ073DMTpP5Z4lm10NWuL\nA3C1wmdNsNf0zS8z5bIawva0iYoHBqzPFpD9RcwYnmL41s2Gq6AuFPsBjqVYJDEV\ndMArb4wnS1b4wsF8xIaR76g/tmt4CZqvi7b1hwNxttbDccJwUxEL1ZGqOQG2JHP1\nI0tvc7JXeeeQ+rslo0eoqYhtVIJhmvNO/cCc7vMCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBAB84Qy/ZUQLyjlf2vEyO4VMSGWCyhPBxUlw4FxeI9iPM\nZELgINv0PTVADkElhgPzKp4JA1z064R7+1tgG1jfwFVrNpNRsZTBxH/wcvk0Fn4K\nWhpq9wi1vbvDVN2Jp9lyFtAIA0pu66cte1NHJacO13uGMOpGFi+d4vlWpvKJDURG\nWtIYCW0jB70XYSTj9t39v/vgPNzM0ATVKK5Z49cPwfyK55cR7YmYhfz0MYoAYXV5\n6f+2KAPXhDY1PZfDv2rBxUHD75WaZDZ1AjL3a+exqrfVLgjq60tLAptHmFZinmzU\n5qg4aXyJqMtnuBLRJl/DpKDGEMnMoQjVTd7vUsqU9aM=\n-----END CERTIFICATE-----\n",
       "2f68ba223cf6c8ff78dda94bb093e93849165e93" => "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIDabYBRtVgC4wDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTYw\nODIwMDA0NTI2WhcNMTYwODIzMDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBALp2ZbW8BEXzmFGb0R9xRV8JInq+o862CUiHxOFodRaBJCiV\nnIhrdAymXPxhe/X6hbN3uusRTQmgoTVWjgYfEVvs5/3krG6dPbld9ScmOFD+dlAr\nKv1CEZ8oordEDoPqYpG/UESpkmy13cFSiJ+6NzCtfSKJU5WSNdxgvwLRkVOnWBQy\n/AwxY7iGGhxZ8X8TIyn6wvePSUuB6lUdTzKRuyzKQE+jUigIKi1LZMEnqEPu00Fo\n/+Q29gVMb+v8DXPfrp2FNjPvv9MAyMKd0gpgUnUVoAw5qrrBzDUV+TbZ/R3gnPIn\nIL3tgxQzeJ6zhM1fyHA/Hgm0VsszKm0M8kfGQEkCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBACKS1Z9OKVNc2i4fnngRxGhMHhsqaqKE+oYrmlKbsFvP\nVNWYlZorOGKdepzXAJob2lG6EttckVoz+LQigtaWJ9EVtmmaiC6B+sbfguAIhBKO\nBWBi4mme5DiuVhGb8WBKF/NobeuWHBWCe08Y1AlOTbiSjBlvRtgiTyL0/Y0xD0TE\nqwPJ6J7Ywpb7TwyXxFjSiyW8YDTBHf740O4ZmgyoAQ3tidXGD8J6XHeibw82zP2N\nbifoJ2ytudw9wUZOYQyT8EYGEznC+ERirsnNXZjb01T0hF0v42EUol8LHfc5ReU5\nkmJJbFVBS2G6aePpUQEFN/ElrReVG3YfuiDj5v/n9KI=\n-----END CERTIFICATE-----\n",
       "10303127bc832e098bf5edeeb9288da739e21e02" => "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIMwwMpSNxtEkwDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTYw\nODIyMDA0NTI2WhcNMTYwODI1MDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAL/ND12nEXZ0Gn2b6MZ6dPbYv+xMyJOQMaXDrFmQpKpvoUSe\ny9r3fsgapSGssUsqjOE4y/SyDDRxxfKrCpNOJq9mY9Pqr5fYKbswheH83S+1Om/r\n4DYr2tpZuj4POf4WIQv9VNDgKykv2wN0nxJJEdIhEMdKPDuhUlr4ImzYOC6Q/lDb\nBUBXyZjsZfNLnNggZZ4E8A14BMn1NHxJXqPeVclcRfVc52iM1XB7s5Pk+xytKJgW\nzyYbOyGU/nHV4Rm6716qN322gOFhCzIZbnIjnqAyXuMpFXolXDw7MXivoXowzPSE\nFatypOZp+rfNjACpRMYf+967C8CuSBxV2xFJwmMCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBABmOwxLlCyfw2lY+1trh9nn6wC5J+5EFymwGMUQe8WtQ\nZOTysj/hgMUZtVGxdh3UlnWA2UPVlceC67jf+pcGRT6YRVbuKZuscwyNXhB9qo9o\nCR2FkbGB0sbEERuo8osaMM1XLIcKW0GNKntdTm2ZHrNZNAWJ7+nvuRDTM10iFgn0\noa9LNIzIWzSz1EDxJ/8JY9aTgjXaWDZMzp7yjymugbhJIVKUgx0KWxg+vi6JP0fU\nmnN14GrS0BVzaOwyE91UjHzFSyfGrm3WS4E1PBtRtENLNRBrUJwvIPqewAPutIjQ\n0kmn7amZucnSERZdXq3L9KNhuzl7jtw1u8narMGXfhU=\n-----END CERTIFICATE-----\n"
      }

      public_keys.first[1]
    end

    def read_token
      request.env["HTTP_AUTHORIZATION"].scan(/Bearer(.*)$/).flatten.last
    end

    def decode_token
      x509 = OpenSSL::X509::Certificate.new(firebase_public_key)
      # TODO: Implement verification for aud, iss
      JWT.decode(jwt_token, x509.public_key, true, { algorithm: "RS256", verify_iat: true })
    end
end
