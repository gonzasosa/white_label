import {getFirestore} from "firebase-admin/firestore";
import {onRequest} from "firebase-functions/https";

// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /courses/:documentId
const postCourseComment = onRequest(async (req, res) => {
  const courseId = req.query.courseId as string;
  const comment = req.query.text as string;

  if (!courseId || !comment) {
    res.status(400).
      send("Invalid request. Please provide courseId and comment.");
    return;
  }

  const db = getFirestore();
  await db.collection("courses").doc(courseId)
    .update({comment: comment});

  res.json({result: "Comment added."});
});

export {postCourseComment};
