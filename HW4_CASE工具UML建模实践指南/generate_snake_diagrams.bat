@echo off
echo ===== 批量生成Snake Game UML图表 =====

:: 设置控制台编码为UTF-8
chcp 65001 > nul

:: 设置路径变量
set PLANTUML_JAR=uml_tools\plantuml.jar
set SNAKE_DIR=uml_diagrams\snake_game
set OUTPUT_DIR=uml_diagrams\generated_images

:: 验证PlantUML JAR文件存在
if not exist %PLANTUML_JAR% (
    echo [错误] 找不到 %PLANTUML_JAR%
    echo 请确保PlantUML已正确下载到uml_tools目录
    pause
    exit /b 1
)

:: 创建输出目录
if not exist %OUTPUT_DIR% mkdir %OUTPUT_DIR%
if not exist %OUTPUT_DIR%\png mkdir %OUTPUT_DIR%\png
if not exist %OUTPUT_DIR%\svg mkdir %OUTPUT_DIR%\svg

echo 1. 生成Snake Game UML图表...
if exist %SNAKE_DIR%\*.puml (
    echo   生成PNG格式...
    java -Dfile.encoding=UTF-8 -Dplantuml.include.path=. -jar %PLANTUML_JAR% -charset UTF-8 -tpng -o ..\generated_images\png %SNAKE_DIR%\*.puml
    echo   生成SVG格式...
    java -Dfile.encoding=UTF-8 -jar %PLANTUML_JAR% -charset UTF-8 -tsvg -o ..\generated_images\svg %SNAKE_DIR%\*.puml
    echo   Snake Game图表生成完成
) else (
    echo   [警告] 未找到Snake Game的PlantUML文件
)
echo.

echo 2. 生成项目类图（使用Pyreverse）...
echo   生成Snake Game类图...
if exist "Snake Game\snake_game.py" (
    cd "Snake Game"
    pyreverse -o png -p SnakeGame_Auto -d ..\uml_diagrams\pyreverse_output snake_game.py
    cd ..
    echo   Snake Game Pyreverse类图生成完成
) else (
    echo   [警告] 未找到Snake Game源文件
)
echo.

echo ===== 图表生成完成 =====
echo.
echo 图表文件位置：
echo - PNG格式: %OUTPUT_DIR%\png\
echo - SVG格式: %OUTPUT_DIR%\svg\
echo - Pyreverse: uml_diagrams\pyreverse_output\
echo.
echo 生成的图表包括：
echo.
echo Snake Game:
echo   - 用例图 (snake_game_usecase.png)
echo   - 类图 (snake_game_class.png)
echo   - 时序图 (snake_game_sequence.png)
echo   - 状态图 (snake_game_state.png)
echo   - 活动图 (snake_game_activity.png)
echo   - 自动生成类图 (classes_SnakeGame_Auto.png)
echo.

:: 检查生成结果
echo 3. 验证生成结果...
echo PNG图表文件:
dir %OUTPUT_DIR%\png\*.png
echo.
echo Pyreverse图表文件:
dir uml_diagrams\pyreverse_output\*.png
echo.

:: 自动打开输出目录
echo 正在打开图表目录...
explorer %OUTPUT_DIR%\png

pause
