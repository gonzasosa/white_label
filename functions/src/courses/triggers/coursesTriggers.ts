import {QueryDocumentSnapshot, getFirestore} from "firebase-admin/firestore";
import {FirestoreEvent, onDocumentCreated}
  from "firebase-functions/v2/firestore";

const makeUppercaseCourseName = onDocumentCreated(
  "/courses/{courseId}",
  async (event: FirestoreEvent<QueryDocumentSnapshot | undefined>) => {
    if (!event.data) {
      console.log("No data found in event.");
      return;
    }

    const courseId = event.params.courseId;
    const data = event.data?.data();

    const db = getFirestore();
    await db.collection("courses").doc(courseId).update({
      name: data.name.toUpperCase(),
    });
  });

export {makeUppercaseCourseName};
