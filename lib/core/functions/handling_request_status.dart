

import '../class/request_status.dart';

RequestStatus handlingRequestStatus(response){
  if(response is RequestStatus){
        return response ;
  }else{
   return RequestStatus.success;
  }
}