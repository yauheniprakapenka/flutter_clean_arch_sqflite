package com.example.geoquiz

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import kotlin.math.log

private const val TAG = "MainActivity"

class MainActivity : AppCompatActivity() {
    private lateinit var trueButton: Button
    private lateinit var falseButton: Button
    private lateinit var nextButton: Button
    private lateinit var previousButton: Button
    private lateinit var questionTextView: TextView

    private val questionBank = listOf(
        Question(R.string.question_australia, true),
        Question(R.string.question_oceans, true),
        Question(R.string.question_mideast, false),
//        Question(R.string.question_africa, false),
//        Question(R.string.question_americas, true),
//        Question(R.string.question_asia, true),
    )

    private var currentIndex = 0
    private var selectedAnswer: Boolean? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_main)
        findViewsById()

        trueButton.setOnClickListener { view: View ->
            onTrueButtonClicked()
        }

        falseButton.setOnClickListener { view: View ->
            onFalseButtonClicked()
        }

        nextButton.setOnClickListener { view: View ->
            val nextQuestionIndex = getNextQuestionIndex(questionBank.count(), currentIndex)
            if (nextQuestionIndex != null) {
                currentIndex = nextQuestionIndex
                updateQuestion()
            } else {
                showResult()
            }
        }

        questionTextView.setOnClickListener { view: View ->
            currentIndex += 1
            updateQuestion()
        }

        previousButton.setOnClickListener { view: View ->
            currentIndex -= 1
            updateQuestion()
        }

        updateQuestion()
    }

    private fun showResult() {
        val totalQuestions = questionBank.count()
        val correctAnswers = countCorrectAnswers(questionBank)
        val correctAnswersPerPercent = getPercentFromNumber(totalNumbers = totalQuestions, fromNumber = correctAnswers)
        Toast.makeText(this, "Правильных ответов: $correctAnswersPerPercent%", Toast.LENGTH_SHORT).show()
    }

    private fun updateQuestion() {
        val questionTextResId = questionBank[currentIndex].textResId
        val questionNumber = currentIndex + 1
        val questionString = resources.getString(resources.getIdentifier(questionTextResId.toString(), "string", packageName))
        questionTextView.text = "$questionNumber. $questionString"
    }

    private fun onTrueButtonClicked() {
        if (selectedAnswer == null) {
            val result = true
            selectedAnswer = result
            questionBank[currentIndex].userAnswer = result
        }
    }

    private fun onFalseButtonClicked() {
        if (selectedAnswer == null) {
            val result = false
            selectedAnswer = result
            questionBank[currentIndex].userAnswer = result
        }
    }

    // Returns [null] if no more questions.
    private fun getNextQuestionIndex(totalQuestions: Int, currentQuestion: Int): Int? {
        val formattedTotalQuestions = totalQuestions - 1
        if (currentQuestion < formattedTotalQuestions) {
            clearUserAnswer()
            return currentQuestion + 1
        }
        return null
    }

    private fun findViewsById() {
        trueButton = findViewById(R.id.true_button)
        falseButton = findViewById(R.id.false_button)
        nextButton = findViewById(R.id.next_button)
        previousButton = findViewById(R.id.previous_button)
        questionTextView = findViewById(R.id.question_text_view)
    }

    private fun clearUserAnswer() {
        selectedAnswer = null
    }

    private fun countCorrectAnswers(questionBank: List<Question>): Int {
        var rightAnswers = 0
        for (question in questionBank) {
            if (question.answer == question.userAnswer) {
                rightAnswers++
            }
        }
        return rightAnswers
    }

    private fun getPercentFromNumber(totalNumbers: Int, fromNumber: Int): Int {
        val totalPercent = 100
        return (totalPercent * fromNumber) / totalNumbers
    }

}