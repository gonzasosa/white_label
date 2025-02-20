import {getFirestore} from "firebase-admin/firestore";
import {onRequest} from "firebase-functions/https";

// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /courses/:documentId
const postCourseComment = onRequest(async (req, res) => {
  console.log(req.body);
  const courseId = req.body.courseId;
  const comment = req.body.comment;

  if (!courseId || !comment) {
    res.status(400).
      send("Invalid request. Please provide courseId and comment.");
    return;
  }

  const db = getFirestore();
  await db.collection("courses").doc(courseId)
    .update({comment: comment});

  res.status(200).send();
});

export {postCourseComment};
