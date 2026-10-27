k#!/bin/bash
YEAR=${2:-$(date +%Y)}
MONTH=${1:-$(date +%-m)}
MONTH_NAME=$(LC_TIME=en_US.UTF-8 date -d "$YEAR-$MONTH-01" +%B)

echo "<span size='large' weight='bold'>$MONTH_NAME $YEAR</span>"
echo ""
echo "<span weight='bold'>Mon Tue Wed Thu Fri Sat Sun</span>"
cal -m $MONTH $YEAR | tail -n +3 | while IFS= read -r line; do
    out=""
    for (( col=0; col<7; col++ )); do
        day="${line:$((col * 3)):2}"
        day=$(echo "$day" | tr -d ' ')
        if [ -z "$day" ]; then
            out="$out    "
            continue
        fi
        DAY_NUM=$(printf "%02d" "$day")
        color="#dddddd"
        if [ $col -eq 6 ]; then color="#ff6666"; fi
        out="$out<span foreground='$color'>$(printf "%3s" "$day")</span> "
    done
    echo "$out"
done
