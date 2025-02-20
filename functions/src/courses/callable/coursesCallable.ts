import {getFirestore} from "firebase-admin/firestore";
import {onCall} from "firebase-functions/https";

const buyCourse = onCall(async (request) => {
  const courseId = request.data.courseId;

  if (!courseId) {
    throw new Error("Invalid request. Please provide courseId.");
  }

  const db = getFirestore();
  const courseRef = db.collection("courses").doc(courseId);

  const courseData = (await courseRef.get()).data();
  if (!courseData) {
    throw new Error("Course not found");
  }

  const numOfPurchases = courseData.numOfPurchases ?? 0;

  // TODO: Open transaction
  await courseRef.update({numOfPurchases: numOfPurchases + 1});
});

export {buyCourse};
