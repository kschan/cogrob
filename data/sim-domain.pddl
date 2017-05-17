(define (domain grand-challenge-sim)
    (:requirements :typing :durative-actions :duration-inequalities)

  (:types
   robot location - object
   start-location recognition-location under-actuated-location grasp-location - location)

  (:predicates
   (at ?l - location)
   (grasp-task-done)
   (under-actuated-task-done)
   (recognition-task-done))

  (:durative-action
   move
   :parameters (?from - location ?to - location)
   :duration (>= ?duration 45)
   :condition (and (at start (at ?from)))
   :effect (and (at start (not (at ?from)))
                (at end (at ?to))))

  (:durative-action
   perform-grasp-task
   :parameters (?loc - grasp-location)
   :duration (>= ?duration 5)
   :condition (and (over all (at ?loc)))
   :effect (and (at end (grasp-task-done))))

  (:durative-action
   perform-recognition-task
   :parameters (?loc - recognition-location)
   :duration (>= ?duration 5)
   :condition (and (over all (at ?loc)))
   :effect (and (at end (recognition-task-done))))

  (:durative-action
   perform-under-actuated-task
   :parameters (?loc - under-actuated-location)
   :duration (>= ?duration 5)
   :condition (and (over all (at ?loc)))
   :effect (and (at end (under-actuated-task-done)))))
