package com.example.myapplication;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import retrofit2.Call;
import retrofit2.Callback;

import io.flutter.embedding.android.FlutterActivity;
import retrofit2.Response;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.view.inputmethod.InputMethodManager;
import android.content.Context;
import android.widget.ProgressBar;
import android.widget.Toast;

public class MainActivity3 extends AppCompatActivity {
    ApiService apiService = RetrofitClient.createApiService();
    LoginRequest request = new LoginRequest("kminchelle", "0lelplR");

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);
        Button myButton = findViewById(R.id.myButton);
        EditText userNameEditText=findViewById(R.id.usernameEditText);
        EditText passwordEditText=findViewById(R.id.passwordEditText);

//        ProgressBar progressBar = findViewById(R.id.progressBar);

        myButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // Handle button click here
                // For example, display a toast message
                if(userNameEditText.getText().toString().isEmpty()||passwordEditText.getText().toString().isEmpty()){
                    showLoginErrorDialog("Enter username and Password","username or password can't be empty");

                }
                else {
                    performLogin(userNameEditText.getText().toString(),passwordEditText.getText().toString());
                    userNameEditText.getText().clear();
                    passwordEditText.getText().clear();


                }
//                progressBar.setVisibility(View.VISIBLE);
//                startActivity(
//                        FlutterActivity.createDefaultIntent(MainActivity3.this)
//                );
            }
        });
    }
    private void performLogin(String usernameEntered,String passwordEntered) {
        // Create an instance of your Retrofit service
        ApiService apiService = RetrofitClient.createApiService();
        Log.d("ENTERED VALUE", "performLogin:username "+usernameEntered);
        // Create a LoginRequest object with the user's input (username and password)
        String username = "kminchelle"; // Replace with user input
        String password = "0lelplR";    // Replace with user input
        LoginRequest request = new LoginRequest(usernameEntered, passwordEntered);

        // Make the API call
        Call<ApiResponse> call = apiService.login(request);
        call.enqueue(new Callback<ApiResponse>() {


            @Override
            public void onResponse(Call<ApiResponse> call, Response<ApiResponse> response) {
                Log.d("RESULT1", "onResponse: "+response.body());

                if (response.isSuccessful()) {
                    ApiResponse apiResponse = response.body();
                    Log.d("RESULT", "onResponse1: "+apiResponse.getUsername());
                    Toast.makeText(getApplicationContext(), "Login Successful!", Toast.LENGTH_SHORT).show();
                    startActivity(
                        FlutterActivity.createDefaultIntent(MainActivity3.this)
                );
                } else {
                    Log.e("ERROR", "onResponse error: "+response);


                    showLoginErrorDialog("Login Failed","Invalid username or password. Please try again.");
                }
            }

            @Override
            public void onFailure(Call<ApiResponse> call, Throwable t) {
                // Handle network or request failure here

                showLoginErrorDialog("Login Failed","Invalid username or password. Please try again.");
            }
        });
    }
    private void hideKeyboard() {
        View view = this.getCurrentFocus();
        if (view != null) {
            InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
            imm.hideSoftInputFromWindow(view.getWindowToken(), 0);
        }
    }
    private void showLoginErrorDialog(String title,String msg) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(title)
                .setMessage(msg)
                .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // You can perform any action here when the user clicks OK
                        dialog.dismiss();

// Hide the keyboard
                    }
                })
                .create()
                .show();
    }
}

