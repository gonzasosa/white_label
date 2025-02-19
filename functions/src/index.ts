import {initializeApp} from "firebase-admin/app";
import {buyCourse, postCourseComment, makeUppercaseCourseName}
  from "./courses/courses";

initializeApp();

exports.buyCourse = buyCourse;
exports.postCourseComment = postCourseComment;
exports.makeUppercaseCourseName = makeUppercaseCourseName;
