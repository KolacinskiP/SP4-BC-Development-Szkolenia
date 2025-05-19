Table 50040 "Seminar Registration Header"
{
    LookupPageId = "Seminar Registration List";
    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = true;
            // trigger OnValidate()
            // var
            //     SeminarRegistrationHeader: Record "Seminar Registration Header";
            // begin
            //     if SeminarRegistrationHeader.Get("No.") then
            //         if "No." <> SeminarRegistrationHeader."No." then
            //             Error(SeminarRegistrationNameModyfication);
            // end;
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            trigger OnValidate()
            begin
                if Status <> Status::Planning then
                    Error(StDateChangeInNotPlanningSeminarRegistrationErr);
            end;
        }
        field(3; "Seminar Code"; Code[20])
        {
            Caption = 'Seminar Code';
            TableRelation = "Seminar";

            trigger OnValidate()
            var
                Seminar: Record Seminar;
                SeminarRegLine: Record "Seminar Registration Line";
                SeminarRoom: Record "Seminar Room";
            begin
                if Seminar.Get("Seminar Code") then begin
                    Seminar.TestField(Seminar.Blocked, false);
                    "Seminar Name" := Seminar.Name;
                    "Seminar Duration" := Seminar."Seminar Duration";
                    "Minimum Participants" := Seminar."Minimum Participants";
                    "Maximum Participants" := Seminar."Maximum Participants";
                    // "Seminar Price" := Seminar.""Seminar Price";
                    Validate("Seminar Price", Seminar."Seminar Price");
                end else begin
                    "Seminar Name" := '';
                    "Seminar Duration" := 0;
                    "Minimum Participants" := 0;
                    "Maximum Participants" := 0;
                    "Seminar Price" := 0;
                end;
                SeminarRegLine.Reset();
                SeminarRegLine.SetRange(SeminarRegLine."Seminar Registration No.", "No.");
                if SeminarRegLine.FindSet() then
                    repeat
                        if SeminarRegLine.Registered then
                            Error(SeminarWithRegisteredLinesModifyErr);
                    until SeminarRegLine.Next() = 0;

                SeminarRoom.Reset();
                Seminar.Reset();
                if SeminarRoom.Get("Seminar Room Code") and Seminar.Get("Seminar Code") then
                    if SeminarRoom."Maximum Participants" < Seminar."Maximum Participants" then
                        Error(SeminarRoomSpaceErr);

            end;

        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';
        }
        field(5; "Instructor Code"; Code[20])
        {
            Caption = 'Instructor Code';
            TableRelation = "Instructor";

            trigger OnValidate()
            var
                Instructor: Record "Instructor";
            begin
                if Instructor.Get("Instructor Code") then begin
                    "Instructor Name" := Instructor.Name;
                end else begin
                    "Instructor Name" := '';
                end;
            end;
        }
        field(6; "Instructor Name"; Text[100])
        {
            Caption = 'Instructor Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Instructor".Name where("Code" = field("Instructor Code")));
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Planning,Registration,Finished,Cancelled;
            OptionCaption = 'Planning,Registration,Finished,Cancelled';
        }
        field(8; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;
        }
        field(9; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
        }
        field(10; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(11; "Seminar Room Code"; Code[20])
        {
            Caption = 'Seminar Room Code';
            TableRelation = "Seminar Room";

            trigger OnValidate()
            var
                Seminar: Record Seminar;
                SeminarRoom: Record "Seminar Room";
            begin
                if SeminarRoom.Get("Seminar Room Code") then begin
                    "Seminar Room Name" := SeminarRoom.Name;
                    "Seminar Room Address" := SeminarRoom.Address;
                    "Seminar Room Address 2" := SeminarRoom."Address 2";
                    "Seminar Room Post Code" := SeminarRoom."Post Code";
                    "Seminar Room City" := SeminarRoom.City;
                    "Seminar Room Phone No." := SeminarRoom."Phone No.";
                end else begin
                    "Seminar Room Name" := '';
                    "Seminar Room Address" := '';
                    "Seminar Room Address 2" := '';
                    "Seminar Room Post Code" := '';
                    "Seminar Room City" := '';
                    "Seminar Room Phone No." := '';
                end;
                SeminarRoom.Reset();
                Seminar.Reset();
                if SeminarRoom.Get("Seminar Room Code") and Seminar.Get("Seminar Code") then
                    if SeminarRoom."Maximum Participants" < Seminar."Maximum Participants" then
                        Error(SeminarRoomSpaceErr);
            end;
        }
        field(12; "Seminar Room Name"; Text[50])
        {
            Caption = 'Seminar Room Name';
        }
        field(13; "Seminar Room Address"; Text[50])
        {
            Caption = 'Seminar Room Address';
        }
        field(14; "Seminar Room Address 2"; Text[50])
        {
            Caption = 'Seminar Room Address 2';
        }
        field(15; "Seminar Room Post Code"; Code[20])
        {
            Caption = 'Seminar Room Post Code';
            TableRelation = "Post Code";
        }
        field(16; "Seminar Room City"; Text[30])
        {
            Caption = 'Seminar Room City';
        }
        field(17; "Seminar Room Phone No."; Text[30])
        {
            Caption = 'Seminar Room Phone No';
        }
        field(18; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(19; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
        }
        field(20; Amount; Decimal)
        {
            Caption = 'Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Seminar Registration Line".Amount where("Seminar Registration No." = field("No.")));
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        SeminarWithRegisteredLinesModifyErr: label 'Seminar with registered lines cannot be modified';

    var
        SeminarRoomSpaceErr: label 'Not enough space for all participants in seminar room';

    var
        DeleteSeminarInRegistrationErr: label 'You cant delete seminar registration with registration status';

    var
        DeleteFinishedSeminarErr: label 'You cant delete seminar registration with finished status';

    var
        SeminarRegistrationNameModyfication: label 'You cant modify seminar registration name';

    var
        StDateChangeInNotPlanningSeminarRegistrationErr: label 'You can modify starting date only in seminar registration with planning status';

    trigger OnInsert()
    begin
        "Posting Date" := WorkDate();
    end;

    trigger OnDelete()
    begin
        if Status = Status::Registration then begin
            Error(DeleteSeminarInRegistrationErr);
        end else
            if Status = Status::Finished then
                Error(DeleteFinishedSeminarErr);

    end;

    trigger OnModify()
    var
        SeminarRegistrationHeader: Record "Seminar Registration Header";
    begin
        if SeminarRegistrationHeader.Get("No.") then
            if "No." <> SeminarRegistrationHeader."No." then
                Error(SeminarRegistrationNameModyfication);
    end;

}