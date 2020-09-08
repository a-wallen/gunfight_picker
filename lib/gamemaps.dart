import 'dart:ffi';
import 'package:flutter/material.dart';

// random comment

Map mapCode {
  ["mp_cave_am"]: ["Azhir Cave (Night)", ],
  ["mp_farms2_gw"] : ["Krovnik Farmland", ],
  ["mp_spear"] : ["Rammaza", ],
  ["mp_m_stadium"] : ["Verdansk Stadium", ],
  ["mp_m_showers"] : ["Gulag Showers", ],
  ["mp_promenade_gw"] : ["Barakett Promenade", ],
  ["mp_runner"] : ["Gun Runner", ],
  ["mp_spear_pm"] : ["Rammaza (Night)", ],
  ["mp_vacant"] : ["Vacant", ],
  ["mp_hackney_am"] : ["Hackney Yard (Night)", ],
  ["mp_rust"] : ["Rust", ],
  ["mp_shipment"] : ["Shipment", ],
  ["mp_m_cornfield"] : ["", ],
  ["mp_hackney_yard"] : ["Hackney Yard", ],
  ["mp_m_pine"] : ["Pine", ],
  ["mp_hideout"] : ["Khandor Hideout", ],
  ["mp_m_wallco2"] : ["", ],
  ["mp_layover_gw"] : ["Verdansk Intl. Airport", ],
  ["mp_quarry2"] : ["Karst River Quarry", ],
  ["mp_m_overwinter"] : ["Docks (Winter)", ],
  ["mp_cave"] : ["Azhir Cave", ],
  ["mp_village2"] : ["", ],
  ["mp_m_speed"] : ["", ],
  ["mp_boneyard_gw"] : ["Zhokov Boneyard", ],
  ["mp_petrograd"] : ["St. Petrograd", ],
  ["mp_raid"] : ["Granza Raid", ],
  ["mp_harbor"] : ["Suldal Harbor", ],
  ["mp_m_speedball"] : ["Speedball", ],
  ["mp_garden"] : ["", ],
  ["mp_m_king"] : ["King", ],
  ["mp_aniyah_tac"] : ["Aniya Palace", ],
  ["mp_m_cargo"] : ["Cargo", ],
  ["mp_euphrates"] : ["Euphrates Bridge", ],
  ["mp_downtown_gw"] : ["Tavorsk District", ],
  ["mp_backlot2"] : ["Talish Backlot", ],
  ["mp_scrapyard"] : ["Scrapyard", ],
  ["mp_deadzone"] : ["", ],
  ["mp_m_overunder"] : ["Docks", ],
  ["mp_oilrig"] : ["Petrov Oil Rig", ],
  ["mp_piccadilly"] : ["Piccadilly", ],
  ["mp_m_trench"] : ["Trench", ],
  ["mp_emporium"] : ["", ],
  ["mp_m_stack"] : ["Stack", ],
  ["mp_m_cage"] : ["", ],
  ["mp_runner_pm"] : ["Gun Runner (Night)", ],
  ["mp_m_hill"] : ["Hill", ],
  ["mp_m_fork"] : ["", ],
  ["mp_port2_gw"] : ["Port of Verdansk", ],
  ["mp_aniyah"] : ["Aniya Palace", ],
  ["mp_crash2"] : ["Crash", ],
  ["mp_hardhat"] : ["Hardhat", ],
};

String codeToMapName(String code){
  assert(code.isNotEmpty, "Argument passed was empty");
  mapCode.forEach((key, value) {
    if(key == code)
      print(value[0]);
  });
  return "Not found.";
}

