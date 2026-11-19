const gsap = window.gsap;

/**
 * @type HTMLCanvasElement
 */
let intro;
/**
 * @type CanvasRenderingContext2D
 */
let drawer;

let imageclick = document.createElement("a");

let silly = new Image();
imageclick.style.position = "fixed";
imageclick.appendChild(silly);

let canvas = document.createElement("div");


/**
 * @type {{x: number, y: number}}
 */
let initialOffset;

function startup() {
    canvas.style.position = "sticky";
    canvas.style.height = "800px";
    document.body.appendChild(canvas);

    intro = document.createElement("canvas");
    intro.className = "canvas";
    intro.style.position = "relative";
    intro.width = window.innerWidth;
    intro.height = window.innerHeight;
    canvas.appendChild(intro);

    new FontFace("flixelDefault", "url('bulkAssets/nokiafc22.ttf')").load();

    drawer = intro.getContext("2d");
    drawer.font = "20px flixelDefault"; 
    
    initialOffset = {x: intro.width * 0.35, y: intro.height / 2};
}

const _functions = [drawGreen, drawYellow, drawRed, drawBlue, drawLightBlue];
/**
 * @type Number[]
 */
const _times = [0.041, 0.184, 0.334, 0.495, 0.636];

const _colors = ["#00b922", "#ffc132", "#f5274e", "#3641ff", "#04cdfb"];

function selfInsert() {
    
    new Audio('bulkAssets/flixel.ogg').play();
    for (let time of _times) {
        setTimeout(_functions[_times.indexOf(time)], Number(time * 1000));
    }
}

function drawGreen() {
    drawer.clearRect(0, 0, intro.width, intro.height);
    drawer.fillStyle = _colors[0];
    drawer.fillText("HaxeFlixel", initialOffset.x - 63, initialOffset.y + 90);
    drawer.moveTo(0 + initialOffset.x, -37 + initialOffset.y);
    drawer.beginPath();
    drawer.lineTo(1 + initialOffset.x, -37 + initialOffset.y);
    drawer.lineTo(37 + initialOffset.x, 0 + initialOffset.y);
    drawer.lineTo(37 + initialOffset.x, 1 + initialOffset.y);
    drawer.lineTo(1 + initialOffset.x, 37 + initialOffset.y);
    drawer.lineTo(0 + initialOffset.x, 37 + initialOffset.y);
    drawer.lineTo(-37 + initialOffset.x, 1 + initialOffset.y);
    drawer.lineTo(-37 + initialOffset.x, 0 + initialOffset.y);
    drawer.lineTo(0 + initialOffset.x, -37 + initialOffset.y);
    drawer.closePath();
    drawer.fill();
    console.log("fun");
}
function drawYellow() {
    drawer.fillStyle = _colors[1];
    drawer.fillText("HaxeFlixel", initialOffset.x - 63, initialOffset.y + 90);
    drawer.moveTo(0 + initialOffset.x, 0 + initialOffset.y);
    drawer.beginPath();
    drawer.moveTo(-50 + initialOffset.x, -50 + initialOffset.y);
    drawer.lineTo(-25 + initialOffset.x, -50 + initialOffset.y);
    drawer.lineTo(0 + initialOffset.x, -37 + initialOffset.y);
    drawer.lineTo(-37 + initialOffset.x, 0 + initialOffset.y);
    drawer.lineTo(-50 + initialOffset.x, -25 + initialOffset.y);
    drawer.lineTo(-50 + initialOffset.x, -50 + initialOffset.y);
    drawer.closePath();
    drawer.fill();
    console.log("   ny");
}
function drawRed() {
    drawer.fillStyle = _colors[2];
    drawer.fillText("HaxeFlixel", initialOffset.x - 63, initialOffset.y + 90);
    drawer.beginPath();
    drawer.moveTo(50 + initialOffset.x, -50 + initialOffset.y);
    drawer.lineTo(25 + initialOffset.x, -50 + initialOffset.y);
    drawer.lineTo(1 + initialOffset.x, -37 + initialOffset.y);
    drawer.lineTo(37 + initialOffset.x, 0 + initialOffset.y);
    drawer.lineTo(50 + initialOffset.x, -25 + initialOffset.y);
    drawer.lineTo(50 + initialOffset.x, -50 + initialOffset.y);
    drawer.closePath();
    drawer.fill();
    console.log("      self");
}
function drawBlue() {
    drawer.fillStyle = _colors[3];
    drawer.fillText("HaxeFlixel", initialOffset.x - 63, initialOffset.y + 90);
    drawer.beginPath();
    drawer.moveTo(-50 + initialOffset.x, 50 + initialOffset.y);
    drawer.lineTo(-25 + initialOffset.x, 50 + initialOffset.y);
    drawer.lineTo(0 + initialOffset.x, 37 + initialOffset.y);
    drawer.lineTo(-37 + initialOffset.x, 1 + initialOffset.y);
    drawer.lineTo(-50 + initialOffset.x, 25 + initialOffset.y);
    drawer.lineTo(-50 + initialOffset.x, 50 + initialOffset.y);
    drawer.closePath();
    drawer.fill();
    console.log("           in");
    //complete();
}
function drawLightBlue() {
    silly.src = "bulkAssets/bozo.png";
    imageclick.className = "homeIcon";
    canvas.append(imageclick);
    imageclick.style.zIndex = 2;
    imageclick.style.top = String(intro.height - initialOffset.y - 82) + "px";
    imageclick.style.left = "60%";

    endIntro();

    drawer.fillStyle = _colors[4];
    drawer.fillText("HaxeFlixel", initialOffset.x - 63, initialOffset.y + 90);
    drawer.beginPath();
    drawer.moveTo(50 + initialOffset.x, 50 + initialOffset.y);
    drawer.lineTo(25 + initialOffset.x, 50 + initialOffset.y);
    drawer.lineTo(1 + initialOffset.x, 37 + initialOffset.y);
    drawer.lineTo(37 + initialOffset.x, 1 + initialOffset.y);
    drawer.lineTo(50 + initialOffset.x, 25 + initialOffset.y);
    drawer.lineTo(50 + initialOffset.x, 50 + initialOffset.y);
    drawer.closePath();
    drawer.fill();
    console.log("             sert");
}

function endIntro() {
    let beBackSoon = document.createElement("p");
    beBackSoon.textContent = "be back soon..."
    beBackSoon.style.color = "#3fb7fd";
    beBackSoon.style.position = "absolute";
    beBackSoon.title = "Making a complete overhaul on the bio site. I promise it'll be better than before, so see you soon! :3"
    if ( window.matchMedia("(pointer: coarse)").matches ) beBackSoon.onclick = () => window.alert("Making a complete overhaul on the bio site. I promise it'll be better than before, so see you soon! :3");
    canvas.appendChild(beBackSoon);
    beBackSoon.style.left = "43%";
    beBackSoon.style.top = "55%";

    var what = gsap.timeline();
    gsap.to(".homeIcon", {top: -15, left: 20, scale: 0.6, duration: 1.8, delay: 0.55, ease: "back.inOut", onComplete: () => {
        silly.className = "homepage";
        imageclick.href = "localhost:3000/source/";
        silly.title = "this does nothing btw."
    }});
    what.to(".homeIcon", {rotation: 10, duration: 0.325, delay: 0.5, ease: "power1.inOut"});
    what.to(".homeIcon", {rotation: -5, duration: 0.5, delay: 0.15, ease: "power1.inOut", onComplete: () => silly.src = "bulkAssets/blink.gif"});
    //yo why is that lwk smooth wtf i cant even see the change
    what.to(".homeIcon", {rotation: 0, duration: 0.3, delay: 0.2, ease: "power1.inOut"});

    gsap.to(".canvas", {opacity: 0, ease: "none", duration: 1.5, onComplete: () => {
        intro.remove();
        document.querySelector("html").style.overflow = "auto";
    }});
}

startup();
canvas.onclick = function() {selfInsert(); canvas.onclick = null;}