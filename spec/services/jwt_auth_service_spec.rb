require 'rails_helper'

describe JWTAuthService do
  before(:each) do
    jwt_authentication
  end

  it 'should authenticate jwt request' do
    jwt_service = JWTAuthService.new(@HTTP_AUTHORIZATION)
    expect(jwt_service.authenticate).to eq('fake-uid-id')
  end

  it 'should NOT authenticate with expired token' do
    wrong_token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjI1NmZkZTg3YTc5NDkzNDk3ZDI2MjI4MDdlZDM4YzM0MDc3Yzg3MDMifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vc3VwZXJhY2FvLWRjNjJlIiwibmFtZSI6Ik1pY2hlbCBCb3R0YW4iLCJwaWN0dXJlIjoiaHR0cHM6Ly9zY29udGVudC54eC5mYmNkbi5uZXQvdi90MS4wLTEvcDEwMHgxMDAvMTIzMjEyNjJfMTAxNTQwMDA1NDA1MDM4MTBfNjAzMjUzOTIzMzM3ODUyNzI3M19uLmpwZz9vaD0xNDY5MDlmNmM3YWM5YWQ5NDQ0MGI1ZWFlNTI4ODRjNiZvZT01OTE4QkY3OCIsImF1ZCI6InN1cGVyYWNhby1kYzYyZSIsImF1dGhfdGltZSI6MTQ4NTM2MTcyOCwidXNlcl9pZCI6ImxHazFnN1ZWNU5leE5KQU5nWnJ1d1c3Z01ybTEiLCJzdWIiOiJsR2sxZzdWVjVOZXhOSkFOZ1pydXdXN2dNcm0xIiwiaWF0IjoxNDg1MzYxNzI5LCJleHAiOjE0ODUzNjUzMjksImVtYWlsIjoibWljaGVsLmJvdHRhbkBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZmFjZWJvb2suY29tIjpbIjEwMTU0NDU5MjE3NjQzODEwIl0sImVtYWlsIjpbIm1pY2hlbC5ib3R0YW5AZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoiZmFjZWJvb2suY29tIn19.fkaCSR_1PFb1-SadR2-_D6n_xGPuOmhQVJR10dh5Q8oHLzqPWM5HRzchDbLiFPnnZERllIBL4HDak5qYqZNIfM6_0hZEZl-35Jaleh6-UeiDP-iBONqzkSfKJxShfYwmIxpRZHPs7pUGjFqPwMOgqjuVGMCfB7uoQujl23RbXccjYknmAsb6-ac90q5iVgW62UHlKWR57sBpjM7nyhaG2gIX0Gz5u-rPuBN-GATj3kaxoYjRyjaFqufaYvIui0EoJgN1-7EIlflfpI1y4N0Klnb4Ca-kRUa1CHr0daYYRAEwWlTysHjITfESfgnXkMUl4PmtDbZ_1ixJERg_mTCbnw'

    jwt_service = JWTAuthService.new("Bearer #{wrong_token}")
    expect { jwt_service.authenticate  }.to raise_error(JWT::VerificationError)
  end
end
