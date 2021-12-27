package com.example.criminal

import android.text.format.DateFormat
import androidx.lifecycle.ViewModel
import com.example.database.CrimeRepository
import java.util.*

class CrimeListViewModel: ViewModel() {
    private val crimeRepository = CrimeRepository.get()

    val crimeListLiveData = crimeRepository.getCrimes()

    fun getFormattedDate(date: Long): String {
        // Solution: https://www.geeksforgeeks.org/date-and-time-formatting-in-android/
        val format = "EEEE, LLL dd, yyyy"
        return DateFormat.format(format, date).toString()
    }

    fun addCrime(crime: Crime) {
        crimeRepository.addCrime(crime)
    }
}