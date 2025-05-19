Table 50020 "Instructor"
{
    LookupPageId = "Instructor List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Worker/Subcontractor"; Option)
        {
            Caption = 'Worker/Subcontractor';
            OptionMembers = Worker,Subcontractor;
            OptionCaption = 'Worker,Subcontractor';

            trigger OnValidate()
            begin
                if "Worker/Subcontractor" <> xRec."Worker/Subcontractor" then begin
                    Name := '';
                    "Resource No." := '';
                    "Vendor No." := '';
                end;
            end;
        }
        field(4; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = if ("Worker/Subcontractor" = const(Worker)) Resource where(Type = const("Person"));

            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
                if Resource.Get("Resource No.") then
                    // if "Worker/Subcontractor" = "Worker/Subcontractor"::Worker then
                        Name := Resource.Name

            end;
        }
        field(5; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = if ("Worker/Subcontractor" = const(Subcontractor)) Resource where(Type = const("Machine"));

            trigger OnValidate()
            var
                Vendor: Record Resource;
            begin
                if Vendor.Get("Vendor No.") then
                    // if "Worker/Subcontractor" = "Worker/Subcontractor"::Worker then
                        Name := Vendor.Name

            end;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
}

