import {getFirestore} from "firebase-admin/firestore";
import {Request, Response} from "express";

const createCourseComment = async (req: Request, res: Response) => {
  const courseId = req.params.courseId;
  const comment = req.body.comment;

  if (!courseId || !comment) {
    res.status(400).
      send("Invalid request. Please provide courseId and comment.");
    return;
  }

  const db = getFirestore();
  await db.collection("courses").doc(courseId).collection("comments").
    add({comment: comment});

  res.status(200).send();
};

export {createCourseComment};
