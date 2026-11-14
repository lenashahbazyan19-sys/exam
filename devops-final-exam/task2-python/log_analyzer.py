import json
from collections import Counter

LOG_FILE = "server.log"
REPORT_FILE = "report.json"

def analyze_logs():
    total_logs = 0
    info_count = 0
    warning_count = 0
    error_count = 0
    error_messages = []

    try:
        with open(LOG_FILE, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                total_logs += 1
                parts = line.split(" ", 3)
                if len(parts) < 4:
                    continue
                level, message = parts[2], parts[3]
                if level == "INFO":
                    info_count += 1
                elif level == "WARNING":
                    warning_count += 1
                elif level == "ERROR":
                    error_count += 1
                    error_messages.append(message)
    except FileNotFoundError:
        print(f"Error: '{LOG_FILE}' not found. Please ensure the log file exists.")
        return

    most_common_error = (
        Counter(error_messages).most_common(1)[0][0] if error_messages else None
    )

    report = {
        "total_logs": total_logs,
        "info": info_count,
        "warning": warning_count,
        "error": error_count,
        "most_common_error": most_common_error,
    }

    with open(REPORT_FILE, "w", encoding="utf-8") as out:
        json.dump(report, out, indent=2)

    print("Analysis complete. Report saved to report.json")

if __name__ == "__main__":
    analyze_logs()
