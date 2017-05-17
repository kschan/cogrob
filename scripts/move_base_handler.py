#! /usr/bin/env python

import rospy
from mpex_activity_manager import MpexClient
from geometry_msgs.msg import PoseStamped, Pose, Point, Quaternion
from std_msgs.msg import Header
from actionlib import SimpleActionClient
# from move_base_msgs.msg import MoveBaseAction, MoveBaseGoal

import matlab.engine


def get_coords(loc):
    key = '/locations/' + loc
    return rospy.get_param(key)

def move(lb, ub, from_location, to_location):
    coords = get_coords(to_location)
    header = Header(frame_id='/map')
    point = Point(**coords)
    quat = Quaternion(0, 0, 0, 1)
    pose = Pose(point, quat)

    move_base_client = SimpleActionClient('move_base', MoveBaseAction)
    move_base_client.wait_for_server()

    move_base_client.send_goal(MoveBaseGoal(PoseStamped(header, pose)))
    move_base_client.wait_for_result()

def perform_under_actuated_task(lb, ub, loc):

    # run matlab.engine.shareEngine in MATLAB, also make sure to addpath_drake

    names = matlab.engine.find_matlab()
    if len(names) == 0:
        return
    name = names[0]
    eng = matlab.engine.connect_matlab(name)
    eng.runSimpleCartDoublePendInv(nargout=0)
    return

if __name__=='__main__':
    rospy.init_node('move_base_handler', anonymous=True)
    client = MpexClient()

    move_base_pub = rospy.Publisher('/move_base_simple/goal', PoseStamped,
                                    queue_size=10)
    client.add_listener('perform-under-actuated-task', perform_under_actuated_task)
    client.run()
