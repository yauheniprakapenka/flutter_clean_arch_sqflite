package com.example.criminal

import android.app.Dialog
import android.app.TimePickerDialog
import android.os.Bundle
import android.widget.TimePicker
import androidx.fragment.app.DialogFragment

class TimePickerFragment : DialogFragment() {
    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        return TimePickerDialog(
            requireContext(),
            null,
            13,
            44,
            true
        )
    }

    companion object {
        fun newInstance(): TimePickerFragment {
            return TimePickerFragment()
        }
    }
}