/***
 * Excerpted from "Programming Elm",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/jfelm for more book information.
***/
import Elm from './App.elm';
import './index.css';
import './App.css';
import './ImageUpload.css';

const IMAGE_UPLOADER_ID = 'file-upload';

function fetchSavedNote() {
  let note = localStorage.getItem('note');

  note = note ? JSON.parse(note) : {};

  return {
    title: '',
    contents: '',
    images: [],
    ...note,
  };
}

function saveNote(note) {
  localStorage.setItem('note', JSON.stringify(note));
}

function readImage(file) {
  const reader = new FileReader();

  const promise = new Promise((resolve) => {
    reader.onload = (e) => {
      resolve({
        url: e.target.result,
      });
    };
  });

  reader.readAsDataURL(file);

  return promise;
}

function readImages() {
  const element = document.getElementById(IMAGE_UPLOADER_ID);
  const files = Array.from(element.files);

  Promise.all(files.map(readImage))
    .then(elm.ports.receiveImages.send);
}

const root = document.getElementById('root');
const note = fetchSavedNote();

const elm = Elm.App.embed(root, {
  note,
  imageUploaderId: IMAGE_UPLOADER_ID,
});

elm.ports.uploadImages.subscribe(readImages);
elm.ports.saveNote.subscribe(saveNote);
