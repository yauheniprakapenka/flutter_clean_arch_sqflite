package com.example.geoquiz

import android.os.Build
import androidx.lifecycle.ViewModel

class ApiVersionViewModel: ViewModel() {
    fun getApiVersionText(): String {
        val apiVersion = getApiVersion().toString()
        return "API Level $apiVersion"
    }

    private fun getApiVersion(): Int {
        return Build.VERSION.SDK_INT
    }
}