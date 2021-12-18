package com.example.geoquiz

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.lifecycle.ViewModelProviders

private const val TAG = "MainActivity"

class MainActivity : AppCompatActivity() {
    private lateinit var trueButton: Button
    private lateinit var falseButton: Button
    private lateinit var nextButton: Button
    private lateinit var previousButton: Button
    private lateinit var questionTextView: TextView

    private val quizViewModel: QuizViewModel by lazy {
        ViewModelProviders.of(this).get(QuizViewModel::class.java)
    }

    private fun showResult() {
        val correctAnswersPerPercent = quizViewModel.getResult()
        Toast.makeText(this, "Правильных ответов: $correctAnswersPerPercent%", Toast.LENGTH_SHORT)
            .show()
    }

    private fun updateQuestion() {
        val questionTextResId = quizViewModel.getResourceId()
        val questionString = resources.getString(
            resources.getIdentifier(
                questionTextResId.toString(),
                "string",
                packageName
            )
        )
        questionTextView.text = questionString
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        findViewsById()
        trueButton.setOnClickListener { view: View ->
            quizViewModel.onTrueButtonClicked()
        }

        falseButton.setOnClickListener { view: View ->
            quizViewModel.onFalseButtonClicked()
        }

        nextButton.setOnClickListener { view: View ->
            val hasNextQuestion = quizViewModel.hasNextQuestion()
            if (hasNextQuestion) {
                updateQuestion()
            } else {
                showResult()
            }
        }

        previousButton.setOnClickListener { view: View ->
            quizViewModel.onPreviousButtonClicked()
            updateQuestion()
        }

        updateQuestion()
    }

    private fun findViewsById() {
        trueButton = findViewById(R.id.true_button)
        falseButton = findViewById(R.id.false_button)
        nextButton = findViewById(R.id.next_button)
        previousButton = findViewById(R.id.previous_button)
        questionTextView = findViewById(R.id.question_text_view)
    }
}