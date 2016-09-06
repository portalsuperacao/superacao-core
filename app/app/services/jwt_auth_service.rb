class JWTAuthService
  attr_reader :uid

  def initialize(authorization_header)
    @authorization_header = authorization_header
  end

  def authenticate
    jwt_token = read_token
    raise 'Token not provided' if jwt_token.strip.empty?

    decode_token = decode_token(jwt_token)
    puts decode_token
    @uid = decode_token.first['sub']
    puts "UID: #{@uid}"
  end

  def authenticated?
    @uid != nil
  end

  def current_user
    participant = Participant.find_by_uid(@uid)
    raise "Participant not found for uid: #{uid}" if !participant
  end

  private
    def firebase_public_key
      public_keys =
          {
           "e906cb32400cbcad3a0c82ff427ff9b683b201c5": "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIGgdDEjJVxC8wDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTYw\nOTA2MDA0NTI2WhcNMTYwOTA5MDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBANTHifbm45I8X8X4UASvYJ2ZkGrsxtaXvdAx0MOJrKFqlRVo\nTDI8xDGYdtZWc+/pVqLvIT4Nxg1mLitQ/xpVyQeSxWY1Ot75ElV77f4SQ9YGrAk/\nNb68hIQMx2tUeTs058tkgidqMKdGMIY+dE/Hj1XhOMCzgatxam4DVr8ijyL0J0en\nlF51YFUZ935UtRVIHWNiCelf1JWIIjJnu5gwhMAcztjCJfTkVyPUx60oGdgq0W70\nAgXonfg3Tn/PJDJjUosE5AYrYymWGiVkFhdQI2aYUpm6eUiRTCT+Afnch8Ot1d4F\nSGoQq5VG0oYigmHUFwe/jqda9py34yA2I+bRA7UCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBADvK8R0D8i8ewMy1XIoe/OOUNp+Psx+7LUOew7D+u897\nCL+/SSkN67vkLHVPmj9PYLwZ9K4KZtiDEcN4q30yMkQW/sJ57xAvQU9ONxlpKUeu\nI/uzFlllThRIQuIyb+PBPOwHlrcr8B33OdU6ni7WxbmYXr9cufdbxN1NL5kUAh0T\nmdFawE3LPduBk/1XH3/WjFQPy6MJe8LD9hCi09h+2wTTHyCA+F2nXLkA1m1ioA5f\nDra1CZ01eERZVc8iw3yl8CbykGRx8hEJEpRlC17igFruS6OByDmO/l3AKDHFfi3L\nQn42LbP26wptB69fj40wY9D/5VBCQxf0gOjFmT4Lu7k=\n-----END CERTIFICATE-----\n",
           "a6f52676379e57db8fbaeb489e5d63e0633887bb": "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIHZdp9W5r2jwwDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTYw\nOTA0MDA0NTI2WhcNMTYwOTA3MDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAM71Py6KIVlgcAb0xRGvBf6hxf91ZPMnQGi0anucqjnPDIuQ\nKYxUivY+bXZi1RvRQh0Of7sD2s33oVsPZAfk7HebOJpuyJMrkyE5VX0DXG8SWw80\nOuUgH+sE+7DoFo49hlGCU6YHWihi64WNLMSf7JFGsAfl1MOBuWg2U+uQo7PR0wQs\nv3jdDJNdonRaEovGc4FKXVpxeZr3fan7fuxxSS5ftzJlCf6eAiIolkhfiQg82D6Q\nrQVXhvuYG9dE2KMs0AoAPJSJ56Bmh4QBcR5XYMo+e23VtYyWsxRbpKzL+zD+MfqL\njvwJZ8v0F1dIS9otdgrfJLCuAq6C2CRcniba8mkCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBAJ00I+WVjgmMKGHUHQeTRwm1eZpzX9am+QVxhuUeCy9N\nD3rpdBa6gdhWvCC48jRnOPgVKXz8Ev6bV9kPgeUwlr1vQFIUqQ0rQkMD09b6Nu+c\nQbubtaK9E+GJjDbRFMw201eHtVWfMsqjXFrhk4KBJdQg3iK/Y/qeO+ket8dAsl3t\ngQHYRmp25zx6YQrm6VJBnRD45p+K8tcqkIGJ911rMomkSYxg6VzzL1fHKenbuXAZ\nS/BDQJ5TE34yMMG/TwS90w9uUFrvqQdW8izAmJ3NZPovccBiiy7RX2Q36FHpWffv\nfp27+BfR8/eNc9IcwVD+RkwqqbCeg4pG8i/Ff8T4/RA=\n-----END CERTIFICATE-----\n",
           "f244b3981525e967d84da84bd4ff7212e1000b75": "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIR0igiKxlMLAwDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTYw\nOTA1MDA0NTI2WhcNMTYwOTA4MDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAKOrwGjsiF7gWD5NVEghysfvRxI1NN90clsGHfoSgPntnN1K\nhtmm1vTS2xSKb05VC/uzQjCtDap2M4PW5jjdHxfStHcWZCajtfAEQAq/cTEjsE1+\ntR6VNYy8WeU/60yUW8jBzxB+0f9bxWOG2rPtz953uFyTwglfLqmbQoUHtiY2pD+B\nArBVhGj4Pk2X5l5t7xd8gJ8elkjYopZnwwnEeWWsVbg2++Nnr6rcaloYdYqH0JsL\n9z3a/4X1oLnreKvNeVvdBMIu1Co0p36NiI6KEr95VZeIGGdwreHo4UqM2kqeNdIo\nLJqjrL+VE4t+d5QCAOY13WWmJkUYtqBh1gyO4isCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBAEPug+/qYWOqpg5aOjLlgqlKrGSX4Sy8B3bQZQQpYi8e\nQz0TvhA+J/x8s9EqT5FhhwavW+MFTktf/PGS6MQBeD6UePnv2fVMTd3aTskV0G/4\nP4M+jvsK8OA9BHcwH7uB4WEWqAzhQCFPtuDcDm0TCgMfeApOGSbk920JUssVqGe7\nZaZR+Ip0n4fht7p+vyEMaySjor/Boq7NGBdEt5k1KQrXh6mcarUp9bj2b2OPIyZ4\nhF0nR6+3xQ2Ft84Tn2LLzc8lYxxhk5jAziSG3RcYqw3Kb/pf1Ek92X9GF7CL00Ky\niC/6K3wFGLMmscNqU6LgEb84KOgLGIoB/YG5k+7YFCk=\n-----END CERTIFICATE-----\n",
           "fc55ac587841e5ef478961b2342768cb746f614f": "-----BEGIN CERTIFICATE-----\nMIIDHDCCAgSgAwIBAgIIPRQ3JnZ/99YwDQYJKoZIhvcNAQEFBQAwMTEvMC0GA1UE\nAxMmc2VjdXJldG9rZW4uc3lzdGVtLmdzZXJ2aWNlYWNjb3VudC5jb20wHhcNMTYw\nOTA3MDA0NTI2WhcNMTYwOTEwMDExNTI2WjAxMS8wLQYDVQQDEyZzZWN1cmV0b2tl\nbi5zeXN0ZW0uZ3NlcnZpY2VhY2NvdW50LmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD\nggEPADCCAQoCggEBAMjxzw2gHp8lGsSZs9VQqCw+c0Vxz4DkrujOrBB49W/A3/IT\npuTV53COeE0brYfcdl3MjezineOQvvClAGk8PFA23GkOclYyG6BAYF0PxWDUvPvY\nrBq92l4UQiSZsW2uNw6AP6zudTcyEQ4Acsnj7j6E+VAa0kVFfH77CRG92XGy+6TC\nzAGKFwhF6vke+CcMdkKR1FJVcv0L7TclJJX8foEH2GnaFK2ODAlWx0zfRvPiM3pj\n4OsC5BmGbBnipptj/tiOjnqBWj0z66PL+r17FkaMccfA2MnTlVCmyecorUcwU4Tg\nnv4apDXGnhME3Zf52VuSedvEWJdv4q1jwojkgCcCAwEAAaM4MDYwDAYDVR0TAQH/\nBAIwADAOBgNVHQ8BAf8EBAMCB4AwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwIwDQYJ\nKoZIhvcNAQEFBQADggEBAJWeMoOc3FxZdTNk5ilaRRkqomUlgb8RH3hSKsytCk/9\nR0l2seXRdv5jGHcTdtC5Z4qB2gm1e9Kg5wPGfJslCKeoENLLlxtMv1MI17qwlcQe\na1kllGt2tUdLjZcgP1O9gR4KJbwXBM04nraDFqS1i5sOtDkJ6Mpum41+lMEvVone\nHsOxkw4Rq5ZZfvxjU2YKF23QytPeGtQWJFAPf1nVYrdIEnvl843Z41d22VCCxl+x\nH6nCZR12ZPKmDYLRESF1dcDxugJxXlPqhi+CXeAPBevhvaDvoncel5U6CNvWaaj0\n6CJJ7XGTreZM3mebvKDeOCCSIJ6FM+EQ8OfhMDY9DMk=\n-----END CERTIFICATE-----\n"
          }
      public_keys.first[1]
    end

    def read_token
      @authorization_header.scan(/Bearer(.*)$/).flatten.last
    end

    def decode_token(jwt_token)
      x509 = OpenSSL::X509::Certificate.new(firebase_public_key)
      # TODO: Implement verification for aud, iss
      JWT.decode(jwt_token.strip, x509.public_key, true, { algorithm: "RS256", verify_iat: true })
    end
end
