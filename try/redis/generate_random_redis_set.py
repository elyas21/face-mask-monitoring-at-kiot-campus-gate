import redis
import datetime
import random


r = redis.Redis(host='localhost', port=6379)
last_time_tmp = str(datetime.datetime.now())[:-6]


while True:

    id = random.randint(0, 10)
    now_time_tmp = str(datetime.datetime.now())[
        :-7] if last_time_tmp != str(datetime.datetime.now())[:-6] else last_time_tmp
    print(id)
    r.sadd('no_mask_list_'+now_time_tmp+'_'+str(0), id)
    print('no_mask_list_'+now_time_tmp+'_'+str(0))
