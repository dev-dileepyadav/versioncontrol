import { LightningElement } from 'lwc';
import myResource from '@salesforce/resourceUrl/js';
import { loadScript } from "lightning/platformResourceLoader";


export default class LwcCasurol extends LightningElement {

    async connectedCallback() {
        try {
          await loadScript(this, myResource);
          // Code to execute after the script is loaded successfully
        } catch (error) {
          // Handle any errors that occurred during script loading
        }
      }

    /*
    renderedCallback(){

        setInterval(function () {
            let slides = document.getElementsByClassName("mySlides");
        let dots = document.getElementsByClassName("dot");
        let slideIndex = 0;
        let isPaused = false;
        let autoTiming = 5000;
        var autoNextSlide = setInterval(function () {
          plusSlides(1)
        }, autoTiming);
        
        // Next/previous controls
        function plusSlides(n) {
          slideIndex += n;
          let max = slides.length - 1;
          if (slideIndex > max) {
            slideIndex = 0;
          }
          if (slideIndex < 0) {
            slideIndex = max;
          }
        
          if (!isPaused) {
            clearInterval(autoNextSlide);
            autoNextSlide = setInterval(function () {
              plusSlides(1)
            }, autoTiming);
          }
          showSlides();
        }
        
        // Thumbnail image controls
        function currentSlide(n) {
          slideIndex = n;
          if (!isPaused) {
            clearInterval(autoNextSlide);
            autoNextSlide = setInterval(function () {
              plusSlides(1)
            }, autoTiming);
          }
          showSlides();
        }
        
        function showSlides() {
          for (let i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
          }
          for (let i = 0; i < dots.length; i++) {
            dots[i].classList.remove("active");
          }
          slides[slideIndex].style.display = "block";
          dots[slideIndex].classList.add("active");
          //console.log("updated carousel slide=" + slideIndex + ", len slides=" + slides.length + ", len dots=" + dots.length);
        }
        
        function togglePause() {
          isPaused = !isPaused;
          if (isPaused) {
            document.getElementById("pause").style.display = "none";
            document.getElementById("play").style.display = "inline";
            clearInterval(autoNextSlide);
          } else {
            document.getElementById("play").style.display = "none";
            document.getElementById("pause").style.display = "inline";
            autoNextSlide = setInterval(function () {
              plusSlides(1)
            }, autoTiming);
          }
        }
        
        for (let i = 0; i < dots.length; i++) {
          dots[i].addEventListener("click", function () {
            currentSlide(i);
          });
          dots[i].addEventListener('keypress', function (e) {
            if (e.key === 'Enter') {
              currentSlide(i);
            }
          });
        }
        
        
        document.querySelector("#prev").addEventListener("click", function () {
          plusSlides(-1);
        });
        document.querySelector("#prev").addEventListener('keypress', function (e) {
          if (e.key === 'Enter') {
            plusSlides(-1);
          }
        });
        document.querySelector("#next").addEventListener("click", function () {
          plusSlides(1);
        });
        document.querySelector("#next").addEventListener('keypress', function (e) {
          if (e.key === 'Enter') {
            plusSlides(1);
          }
        });
        document.querySelector("#carousel-play-pause-container").addEventListener("click", function () {
          togglePause();
        });
        document.querySelector("#carousel-play-pause-container").addEventListener('keypress', function (e) {
          if (e.key === 'Enter') {
            togglePause();
          }
        });
        document.querySelector("#carousel-spinner").addEventListener('pagehide', function () {
          document.getElementById("carousel-spinner").style.display = "block";
        });
        document.getElementById("carousel-spinner").style.display = "none";
        document.getElementById("carousel-controls").style.display = "block";
        
        
        showSlides();
        }, 6000);
    }
    */
    }