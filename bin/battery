#!/bin/sh

OUTPUT=`acpi`

IS_DISCHARGING=`echo "$OUTPUT" | grep -c "Discharging"`
IS_NOT_CHARGING=`echo "$OUTPUT" | grep -c "Not charging"`
IS_CHARGING=`echo "$OUTPUT" | grep -c "Charging"`

if [[ "$IS_CHARGING" != "0" ]] ; then
	VALUE=`echo "$OUTPUT" | awk '{print $4}' | sed 's/..$//'`
elif [[ "$IS_DISCHARGING" != "0" ]] ; then
	VALUE=`echo $OUTPUT | awk '{print $4}' | sed 's/..$//'`
elif [[ "$IS_NOT_CHARGING" != "0" ]] ; then
	VALUE=`echo $OUTPUT | awk '{print $5}' | sed 's/.$//'`
fi

if [[ "$1" == "value" ]]; then
  echo -e "${VALUE}"
elif [[ "$1" == "is_charging" ]]; then
  if [[ "$IS_CHARGING" != "0" ]]; then
    echo -e "1"
  else
    echo -e "0"
  fi
elif [[ "$1" == "both" ]]; then
  if [[ "$IS_CHARGING" != "0" ]] ; then
    echo "${VALUE}C"
  elif [[ "$IS_DISCHARGING" != "0" ]] ; then
    echo "${VALUE}N"
  elif [[ "$IS_NOT_CHARGING" != "0" ]] ; then
    echo "${VALUE}N"
  fi
fi
