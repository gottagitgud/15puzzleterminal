program puzzle;
uses crt, sysutils, dateutils;
var
key, up, down, right, left: char;
axis1, axis2, i, j, k, x: integer; counter: longint; seconds: int64;
beginning, ending: TDateTime;
board: array[1..4,1..4] of string; 

procedure assign;
begin
	board[1][1]:='1 '; board[1][2]:='2 '; board[1][3]:='3 '; board[1][4]:='4 '; board[2][1]:='5 '; board[2][2]:='6 ';  board[2][3]:='7 '; board[2][4]:= '8 '; board[3][1] := '9 '; board[3][2] := '10'; board[3][3] := '11'; board[3][4] := '12'; board[4][1] := '13'; board[4][2] := '14'; board[4][3] := '15'; board[4][4] := '  ';
    up:='i'; left:='j'; down:='k'; right:='f';
end;

procedure changecontrols;
begin
	writeln('Introduce controls: '); writeln();
	writeln('Up:'); up:=ReadKey;
	writeln('Left:'); left:=ReadKey;
	writeln('Down:'); down:=ReadKey;
	writeln('Right:'); right:=ReadKey;
end;

procedure menu;
begin
	writeln('Welcome to the 15-puzzle'); writeln();
	writeln('[1] Start game');
	writeln('[2] Change controls');
	if ReadKey='2' then changecontrols
end;

procedure showboard;
begin
	writeln(); writeln(); writeln('       -----------'); write('      |');
	for i:=1 to 4 do
	begin
		for j:=1 to 4 do
		begin
			if j<>4 then write(board[i][j],'|') else writeln(board[i][j],'|')
		end;
		if i<>4 then write('      |') else writeln('       -----------');
	end;
	writeln(); write('Moves: ',IntToStr(counter))
end;

function localize1: integer;
begin
    for i:=1 to 4 do
    begin
        for j:=1 to 4 do
        begin
            if (board[i][j] = '  ') then
            localize1:=i
        end;
    end;
end;

function localize2: integer;
begin
    for i:=1 to 4 do
    begin
        for j:=1 to 4 do
        begin
            if (board[i][j] = '  ') then
            localize2:=j
        end;
    end;
end;

procedure move(mov: char);
begin
	axis1:= localize1();
    axis2:= localize2();
	if mov=down then
	begin
		if(axis1<>1)then
        begin
            board[axis1][axis2] := board[axis1-1][axis2];
            board[axis1-1][axis2] := '  '
        end 
     end;
    if mov=up then
    begin
		if(axis1<>4) then
		begin
			board[axis1][axis2] := board[axis1+1][axis2];
			board[axis1+1][axis2] := '  '
		end
	end;
	if mov=left then
	begin
		if(axis2<>4) then
		begin
			board[axis1][axis2] := board[axis1][axis2+1];
			board[axis1][axis2+1] := '  '
		end
	end;
	if mov=right then
	begin
		if(axis2<>1) then
		begin
			board[axis1][axis2] := board[axis1][axis2-1];
			board[axis1][axis2-1] := '  '
		end
	end;
	counter:=counter+1
end;

function solved: boolean;
begin
	if (board[1][1] = '1 ') and (board[1][2] = '2 ') and (board[1][3] = '3 ') and (board[1][4] = '4 ') and (board[2][1] = '5 ') and (board[2][2] = '6 ') and (board[2][3] = '7 ') and (board[2][4] = '8 ') and (board[3][1] = '9 ') and (board[3][2] = '10') and (board[3][3] = '11') and (board[3][4] = '12') and (board[4][1] = '13') and (board[4][2] = '14') and (board[4][3] = '15') and (board[4][4] = '  ') then solved:=true
end;

procedure play;
begin
	randomize;
	for k:=1 to 200 do
	begin
		x:=random(4);
		if x=0 then move(up);
		if x=1 then move(down);
		if x=2 then move(right);
		if x=3 then move(left);
		write (x, ' ');
		ClrScr;
	end;
	counter:=0;
    while (solved=false) do
    begin
        showboard;
        key:=ReadKey;
        move(key);
        if counter=1 then beginning:=now;
        ClrScr;
    end;
    ending:=now;
    seconds:=SecondsBetween(beginning,ending);
    ClrScr;
    writeln('Congratulations! You have won'); 
    writeln('You solved it in ', seconds,' seconds');
    write('Do you want to play again? [y/n]');
    if ReadKey='y' then play
end;

begin
	assign;
    menu;
    ClrScr;
    play
end.