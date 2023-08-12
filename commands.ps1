function hello {echo "hiiiii"}

function greet { echo "Hello World" }

function return {cd $workspace }

function nexus { cd "C:\Users\Ahmad\ONEDRI~1\NEXUS" }

function project-3 {cd "C:\Users\Ahmad\ONEDRI~1\NEXUS\ACADEMIC\LEVEL 3\8283 COBOL\DELIVRABLES\Project 3"}

function clr {cls ; # Display Pending Tasks section
echo " __      __        __                                "
echo "/  \    /  \ ____ |  |   ____   ____   _____   ____  "
echo "\   \/\/   // __ \|  | _/ ___\ / __ \ /     \_/ __ \ "
echo " \        /\  ___/_  |__  \___(  \_\ )  | |  \  ___/_"
echo "  \__/\__/  \___  /____/\___  /\____/|__|_|  /\___  /"
echo "                \/          \/             \/     \/ "

echo ""
echo "To list commands:   listcmd"
echo "To add commands:    addcmd"
echo "To modify commands: modcmd"

echo ""
echo "Pending Tasks:"
echo "----------------"
echo "[1] Task A - In Progress"
echo "[2] Task B - Pending"
echo "[3] Task C - Completed"
echo ""
echo "What would you like to do?"
echo ""
}