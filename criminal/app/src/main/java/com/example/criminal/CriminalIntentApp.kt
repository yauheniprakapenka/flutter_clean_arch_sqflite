package com.example.criminal

import android.app.Application
import com.example.database.CrimeRepository

class CriminalIntentApp: Application() {
    override fun onCreate() {
        super.onCreate()
        CrimeRepository.initialize(this)
    }
}