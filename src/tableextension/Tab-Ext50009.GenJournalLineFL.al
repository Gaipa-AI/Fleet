tableextension 50009 "Gen. Journal Line FL" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; "Advance Code"; Code[20])
        {
            TableRelation = Employee."No.";
        }
        field(50002; "Equipment No."; code[100])
        {
            TableRelation = "Fixed Asset"."No.";
            trigger OnValidate()
            var
                Equipment: Record "Fixed Asset";
            begin
                IF "Equipment No." <> '' THEN BEGIN
                    IF Equipment.GET("Equipment No.") THEN BEGIN
                        Equipment.TestField("Equipment Type");
                        IF Equipment."Blocked" THEN
                            ERROR('Equipment: %1 is blocked.', Equipment."No.")
                        else begin
                            Rec.validate("Equipment Type", Equipment."Equipment Type");
                            Rec.Modify();
                        end;
                    END;
                END else begin
                    "Equipment Type" := '';
                    Rec.Modify();
                end;
            end;
        }
        field(50003; "Equipment Type"; Code[100])
        {
            TableRelation = "General value".Code where(Type = const("Equipment Type"));
        }
        field(50009; "Responsible Employee"; Code[50])
        {
            TableRelation = Employee."No.";
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}