package com.example.criminal

import androidx.lifecycle.ViewModel

class CrimeListViewModel: ViewModel() {
    val crimes = mutableListOf<Crime>()

    init {
        crimes.addAll(addCrimes())
    }

    private fun addCrimes(): MutableList<Crime> {
        val crimes = mutableListOf<Crime>()
        for (i in 0 until 100) {
            val crime = Crime()
            crime.title = "Crime #$i"
            crime.isSolved = i % 2 == 0
            crimes += crime
        }
        return crimes
    }
}