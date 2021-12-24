package com.example.criminal

import android.text.format.DateFormat
import androidx.lifecycle.ViewModel
import com.example.database.CrimeRepository
import java.util.*

class CrimeListViewModel: ViewModel() {
//    val crimes = mutableListOf<Crime>()
//
//    init {
//        crimes.addAll(addCrimes())
//    }
//
//    private fun addCrimes(): MutableList<Crime> {
//        val crimes = mutableListOf<Crime>()
//        for (i in 0 until 100) {
//            val crime = Crime()
//            crime.title = "Crime #$i"
//            crime.isSolved = i % 2 == 0
//            crime.date = Date(1563781647000)
//            crimes += crime
//        }
//        return crimes
//    }

    private val crimeRepository = CrimeRepository.get()

    val crimeListLiveData = crimeRepository.getCrimes()

    fun getFormattedDate(date: Long): String {
        // Solution: https://www.geeksforgeeks.org/date-and-time-formatting-in-android/
        val format = "EEEE, LLL dd, yyyy"
        return DateFormat.format(format, date).toString()
    }
}