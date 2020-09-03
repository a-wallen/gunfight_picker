import 'package:flutter/material.dart';

Map mapCode = {
  ["default"] : ["Choose a game mode.", ],
  ["mp_m_stadium"] : ["Verdansk Stadium", ],
  ["mp_m_showers"] : ["Gulag Showers", ],
  ["mp_hackney_am"] : ["Docks", ],
  ["mp_rust"] : ["Rust", ],
  ["mp_shipment"] : ["Shipment", ],
  ["mp_m_cornfield"] : ["Livestock", ],
  ["mp_m_pine"] : ["Pine", ],
  ["mp_m_wallco2"] : ["Speedball", ],
  ["mp_m_speedball"] : ["Speedball", ],
  ["mp_m_king"] : ["King", ],
  ["mp_m_cargo"] : ["Cargo", ],
  ["mp_m_overunder"] : ["Baazar", ],
  ["mp_m_trench"] : ["Trench", ],
  ["mp_m_stack"] : ["Stack", ],
  ["mp_m_cage"] : ["Atrium", ],
  ["mp_m_hill"] : ["Hill", ],
  ["mp_m_fork"] : ["Docks", ],
};

String codeToMapName(String code){
  mapCode.forEach((key, value) {
    if( key == code )
      return value[0];
  });
  return "Not found.";
}

String mapNameToCode(){

}

NetworkImage codeToMapImpage(){

}


