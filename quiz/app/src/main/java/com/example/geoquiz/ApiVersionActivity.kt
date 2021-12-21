package com.example.geoquiz

import android.content.Context
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import androidx.lifecycle.ViewModelProviders

class ApiVersionActivity : AppCompatActivity() {
    private lateinit var apiVersionButton: Button
    private lateinit var apiVersionTextView: TextView

    private val apiVersionViewModel: ApiVersionViewModel by lazy {
        ViewModelProviders.of(this).get(ApiVersionViewModel::class.java)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_api_version)

        apiVersionButton = findViewById(R.id.show_api_version_button)
        apiVersionTextView = findViewById(R.id.api_version_text_view)

        apiVersionButton.setOnClickListener {
            showApiVersion()
        }
    }

    companion object {
        fun newIntent(packageContext: Context): Intent {
            return Intent(packageContext, ApiVersionActivity::class.java)
        }
    }

    private fun showApiVersion() {
        apiVersionTextView.text = apiVersionViewModel.getApiVersionText()
    }
}