import 'package:flutter/material.dart';

const TextStyle webooktextStyle = TextStyle(
  letterSpacing: -0.2,
  fontWeight: FontWeight.bold,
);
const Color purpleColor = Color(0xFF433876);
const Color blackColor = Color(0xFF1e1e1e);

var booksRecomendationData = [
  {
    "BookName": "Glorious Unknown",
    "BookAuthor": "Anna Leva",
    "Image": "gloriousunknown.jpg"
  },
  {
    "BookName": "Rich Dad Poor Dad",
    "BookAuthor": "Robert Kioski",
    "Image": "richdadpoordad.jpg"
  },
  {
    "BookName": "AlChemist",
    "BookAuthor": "Paulo Coelho",
    "Image": "alchemist.jpg"
  },
  {
    "BookName": "Forty Rules Of Love",
    "BookAuthor": "Elif Shafak",
    "Image": "fortyrulesoflove.jpg"
  },
  {
    "BookName": "The Prophet",
    "BookAuthor": "Kahlil Jibran",
    "Image": "theprophet.jpg"
  },
  {
    "BookName": "Why We Sleep",
    "BookAuthor": "Matthew Walker",
    "Image": "whywesleep.jpg"
  },
  {
    "BookName": "The Magic Of Thinking Big",
    "BookAuthor": "David Schwartz",
    "Image": "magicofthinkingbig.jpg"
  },
  {
    "BookName": "The Power Of Now",
    "BookAuthor": "Eckhart Tolle",
    "Image": "thepowerofnow.jpg"
  },
];

var booksInfo = [
  {
    "BookName": "Glorious Unknown",
    "BookAuthor": "Anna Leva",
    "BookEdition": "3rd",
    "InitialPrice": 500,
    "FinalPrice": 550,
    "Stock": 10,
    "Shelf": "Romance",
    "Image": "gloriousunknown.jpg"
  },
  {
    "BookName": "Rich Dad Poor Dad",
    "BookAuthor": "Robert Kioski",
    "BookEdition": "6th",
    "InitialPrice": 550,
    "FinalPrice": 650,
    "Stock": 3,
    "Shelf": "Finance",
    "Image": "richdadpoordad.jpg"
  },
  {
    "BookName": "AlChemist",
    "BookAuthor": "Paulo Coelho",
    "BookEdition": "1st",
    "InitialPrice": 400,
    "FinalPrice": 550,
    "Stock": 35,
    "Shelf": "Life",
    "Image": "alchemist.jpg"
  },
  {
    "BookName": "Forty Rules Of Love",
    "BookAuthor": "Elif Shafak",
    "BookEdition": "3rd",
    "InitialPrice": 300,
    "FinalPrice": 400,
    "Stock": 0,
    "Shelf": "Romance",
    "Image": "fortyrulesoflove.jpg"
  },
  {
    "BookName": "The Prophet",
    "BookAuthor": "Kahlil Jibran",
    "BookEdition": "3rd",
    "InitialPrice": 510,
    "FinalPrice": 590,
    "Stock": 50,
    "Shelf": "Fiction",
    "Image": "theprophet.jpg"
  },
  {
    "BookName": "Why We Sleep",
    "BookAuthor": "Matthew Walker",
    "BookEdition": "1st",
    "InitialPrice": 110,
    "FinalPrice": 200,
    "Stock": 0,
    "Shelf": "Health",
    "Image": "whywesleep.jpg"
  },
  {
    "BookName": "The Magic Of Thinking Big",
    "BookAuthor": "David Schwartz",
    "BookEdition": "4rth",
    "InitialPrice": 90,
    "FinalPrice": 150,
    "Stock": 30,
    "Shelf": "Life",
    "Image": "magicofthinkingbig.jpg"
  },
  {
    "BookName": "The Power Of Now",
    "BookAuthor": "Eckhart Tolle",
    "BookEdition": "1st",
    "InitialPrice": 170,
    "FinalPrice": 200,
    "Stock": 0,
    "Shelf": "Motivation",
    "Image": "thepowerofnow.jpg"
  },
];

var transactions = [
  {
    "TransactionId": "h47j8dk4vd",
    "Year": 2021,
    "Month": 05,
    "Day": 04,
    "Hour": 22,
    "Minute": 12,
    "Second": 14,
    "BookName": "Rich dad poor dad",
    "SoldPrice": 500,
    "BuyerName": "Anonymous"
  },
  {
    "TransactionId": "k48j8dk4vd",
    "Year": 2021,
    "Month": 12,
    "Day": 04,
    "Hour": 22,
    "Minute": 12,
    "Second": 14,
    "BookName": "World Map",
    "SoldPrice": 200,
    "BuyerName": "Hamza Ali"
  },
  {
    "TransactionId": "h47j8dk4vd",
    "Year": 2021,
    "Month": 02,
    "Day": 01,
    "Hour": 22,
    "Minute": 12,
    "Second": 14,
    "BookName": "The Prophet",
    "SoldPrice": 500,
    "BuyerName": "Murad Khan"
  },
  {
    "TransactionId": "h47j8dk4vd",
    "Year": 2021,
    "Month": 01,
    "Day": 04,
    "Hour": 22,
    "Minute": 12,
    "Second": 14,
    "BookName": "Rich dad poor dad",
    "SoldPrice": 500,
    "BuyerName": "Anonymous"
  },
  {
    "TransactionId": "h47j8dk4vd",
    "Year": 2021,
    "Month": 03,
    "Day": 04,
    "Hour": 22,
    "Minute": 12,
    "Second": 14,
    "BookName": "Rich dad poor dad",
    "SoldPrice": 500,
    "BuyerName": "Anonymous"
  },
  {
    "TransactionId": "h47j8dk4vd",
    "Year": 2020,
    "Month": 02,
    "Day": 04,
    "Hour": 22,
    "Minute": 12,
    "Second": 14,
    "BookName": "Rich dad poor dad",
    "SoldPrice": 500,
    "BuyerName": "Anonymous"
  },
  {
    "TransactionId": "h47j8dk4vd",
    "Year": 2021,
    "Month": 02,
    "Day": 04,
    "Hour": 22,
    "Minute": 12,
    "Second": 14,
    "BookName": "Rich dad poor dad",
    "SoldPrice": 500,
    "BuyerName": "Anonymous"
  },
  {
    "TransactionId": "h47j8dk4vd",
    "DateTime": DateTime(2021, 1, 1, 22, 14, 44),
    "BookName": "Rich dad poor dad",
    "SoldPrice": 500,
    "BuyerName": "Anonymous"
  },
];
