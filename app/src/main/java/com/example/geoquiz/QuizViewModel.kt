package com.example.geoquiz

import androidx.lifecycle.ViewModel

//private const val TAG = "QuizViewModel"

class QuizViewModel : ViewModel() {
    private val questionBank = listOf(
        Question(R.string.question_australia, true),
        Question(R.string.question_oceans, true),
        Question(R.string.question_mideast, false),
//        Question(R.string.question_africa, false),
//        Question(R.string.question_americas, true),
//        Question(R.string.question_asia, true),
    )

    var currentIndex = 0
    private var selectedAnswer: Boolean? = null

    fun getCurrentQuestionAnswer(): Boolean {
        return questionBank[currentIndex].answer
    }

    fun getResult(): Int {
        val totalQuestions = questionBank.count()
        val correctAnswers = countCorrectAnswers(questionBank)
        return getPercentFromNumber(totalNumbers = totalQuestions, fromNumber = correctAnswers)
    }

    fun getResourceId(): Int {
        return questionBank[currentIndex].textResId
    }

    fun onTrueButtonClicked() {
        if (selectedAnswer == null) {
            val result = true
            selectedAnswer = result
            questionBank[currentIndex].userAnswer = result
        }
    }

    fun onFalseButtonClicked() {
        if (selectedAnswer == null) {
            val result = false
            selectedAnswer = result
            questionBank[currentIndex].userAnswer = result
        }
    }

    fun onPreviousButtonClicked() {
        currentIndex -= 1
    }

    fun hasNextQuestion(): Boolean {
        val nextQuestionIndex = getNextQuestionIndex()
        if (nextQuestionIndex != null) {
            currentIndex = nextQuestionIndex
            return true
        }
        return false
    }

    // Returns [null] if no more questions.
    private fun getNextQuestionIndex(): Int? {
        val totalQuestions = questionBank.count()
        val currentQuestion = currentIndex
        val formattedTotalQuestions = totalQuestions - 1
        if (currentQuestion < formattedTotalQuestions) {
            clearUserAnswer()
            return currentQuestion + 1
        }
        return null
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