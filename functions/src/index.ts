import {initializeApp} from "firebase-admin/app";
import {buyCourse, createCourseComment, makeUppercaseCourseName}
  from "./courses/courses";
import * as functions from "firebase-functions";
import express from "express";
import cors from "cors";

initializeApp();

const app = express();

app.use(cors({origin: true}));
app.post("/course/:courseId/comments", createCourseComment);

exports.api = functions.https.onRequest(app);
exports.buyCourse = buyCourse;
exports.makeUppercaseCourseName = makeUppercaseCourseName;
