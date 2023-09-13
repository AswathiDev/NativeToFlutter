package com.example.myapplication;


import retrofit2.Call;
        import retrofit2.http.Body;
        import retrofit2.http.Headers;
        import retrofit2.http.POST;

public interface ApiService {
    @Headers("Content-Type: application/json")
    @POST("auth/login")
    Call<ApiResponse> login(@Body LoginRequest request);
}
