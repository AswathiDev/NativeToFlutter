package com.example.myapplication;

import com.google.gson.annotations.SerializedName;

public class ApiResponse {
    @SerializedName("id")
    private int id;

    @SerializedName("username")
    private String username;

    @SerializedName("email")
    private String email;

    @SerializedName("firstName")
    private String firstName;

    @SerializedName("lastName")
    private String lastName;

    @SerializedName("gender")
    private String gender;

    @SerializedName("image")
    private String image;

    @SerializedName("token")
    private String token;

    public int getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getEmail() {
        return email;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getGender() {
        return gender;
    }

    public String getImage() {
        return image;
    }

    public String getToken() {
        return token;
    }
}
