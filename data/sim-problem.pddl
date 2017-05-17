(define (problem grand-challenge-sim)
    (:domain grand-challenge-sim)
  (:objects
   loc1 - start-location
   loc2 - recognition-location
   loc3 - under-actuated-location
   loc4 - grasp-location)
  (:init
   (at loc1))
  (:goal
   (and (at loc1)
        (grasp-task-done)
        (under-actuated-task-done)
        (recognition-task-done))))
