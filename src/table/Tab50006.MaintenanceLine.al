table 50006 "Maintenance Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; enum "Maintenance Type")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Type; Enum "Maintenance Line Type")
        {
            trigger OnValidate()
            begin
                TestField("Document No.");
                GetMaintenanceHeader();
                TestStatusOpen();
            end;
        }
        field(5; "No."; Code[20])
        {
            TableRelation = if (Type = const(" ")) "Standard Text"
            else
            if (Type = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting), Blocked = const(false))
            else
            //if (Type = const("Fixed Asset")) "Fixed Asset"
            //else
            if (Type = const(Item), "Document Type" = filter("Maintenance Request" | "Job Card")) Item where(Blocked = const(false));
            //else
            //if (Type = const(Resource)) Resource;

            // trigger OnValidate()
            // var
            //     myInt: Integer;
            // begin
            //     TestField("Document No.");
            //     GetMaintenanceHeader();
            //     TestStatusOpen();

            //     case Type of
            //         Type::" ":
            //             CopyFromStandardText();
            //         Type::"G/L Account":
            //             CopyFromGLAccount();
            //         Type::Item:
            //             CopyFromItem();
            //         Type::Resource:
            //             CopyFromResource();
            //         Type::"Fixed Asset":
            //             CopyFromFixedAsset();
            //     end;
            // end;
        }
        field(6; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Description 2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Comment; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Quantity; Decimal)
        {
            trigger OnValidate()
            begin
                GetMaintenanceHeader();
                TestStatusOpen();
                Rec.Validate(Amount, Rec.Quantity * Rec."Unit Cost");
            end;
        }
        field(10; "Unit Cost"; Decimal)
        {
            trigger OnValidate()
            begin
                Rec.Validate(Amount, Rec.Quantity * Rec."Unit Cost");
            end;
        }
        field(11; Amount; Decimal)
        {
            Editable = false;
        }
        field(12; Source; Code[100])
        {
            TableRelation = "General value".Code where(Type = filter(Sources));
        }
        field(13; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Unit of Measure".Code;
            trigger OnValidate()
            var
                UnitOfMeasure: Record "Unit of Measure";
            begin
                if UnitOfMeasure.Get(Rec."Unit of Measure Code") then
                    Rec."Unit of Measure" := UnitOfMeasure.Description
                else
                    Rec."Unit of Measure" := '';
            end;
        }
        field(14; "Unit of Measure"; Text[50])
        {
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        MaintenanceHeader: Record "Maintenance Header";

    trigger OnInsert()
    begin
       // Rec.Type := Rec.Type::Item;

    end;

    trigger OnModify()
    var
        MaintenanceHeader: Record "Maintenance Header";
    begin
        if Rec."Document Type" = Rec."Document Type"::"Job Card" then begin
            if MaintenanceHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                MaintenanceHeader.TestField("Job Status", MaintenanceHeader."Job Status"::New);
            end else
                Error('Maintenance Header not found for Document Type %1 and Document No. %2', Rec."Document Type", Rec."Document No.");
        end else if Rec."Document Type" = Rec."Document Type"::"Maintenance Request" then begin
            if MaintenanceHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                MaintenanceHeader.TestField(Status, MaintenanceHeader.Status::Open);
            end else
                Error('Maintenance Header not found for Document Type %1 and Document No. %2', Rec."Document Type", Rec."Document No.");
        end;
    end;

    trigger OnDelete()
    var
        MaintenanceHeader: Record "Maintenance Header";
    begin
        if Rec."Document Type" = Rec."Document Type"::"Job Card" then begin
            if MaintenanceHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                MaintenanceHeader.TestField("Job Status", MaintenanceHeader."Job Status"::New);
            end else
                Error('Maintenance Header not found for Document Type %1 and Document No. %2', Rec."Document Type", Rec."Document No.");
        end else if Rec."Document Type" = Rec."Document Type"::"Maintenance Request" then begin
            if MaintenanceHeader.Get(Rec."Document Type", Rec."Document No.") then begin
                MaintenanceHeader.TestField(Status, MaintenanceHeader.Status::Open);
            end else
                Error('Maintenance Header not found for Document Type %1 and Document No. %2', Rec."Document Type", Rec."Document No.");
        end;
    end;

    trigger OnRename()
    begin
        Error('Renaming records in Maintenance Line is not supported.');
    end;

    procedure GetMaintenanceHeader(): Record "Maintenance Header"
    begin
        GetMaintenanceHeader(MaintenanceHeader);
        exit(MaintenanceHeader);
    end;

    procedure GetMaintenanceHeader(var OutMaintenanceHeader: Record "Maintenance Header")
    var
        myInt: Integer;
    begin
        TestField("Document No.");
        if ("Document Type" <> MaintenanceHeader."Document Type") or ("Document No." <> MaintenanceHeader."No.") then begin
            MaintenanceHeader.Get(Rec."Document Type", Rec."Document No.");
        end;
        OutMaintenanceHeader := MaintenanceHeader;
    end;

    procedure TestStatusOpen()
    begin
        GetMaintenanceHeader();
        MaintenanceHeader.TestField(Status, MaintenanceHeader.Status::Open);
    end;

    local procedure CopyFromStandardText()
    var
        StandardText: Record "Standard Text";
    begin
        StandardText.Get("No.");
        Description := StandardText.Description;
    end;

    local procedure CopyFromGLAccount()
    var
        IsHandled: Boolean;
        GLAcc: Record "G/L Account";
    begin
        GLAcc.Get("No.");
        GLAcc.TestField("Direct Posting", true);
        Description := GLAcc.Name;
    end;

    local procedure CopyFromItem()
    var
        Item: Record Item;
    begin
        if Item.Get(Rec."No.") then begin
            Item.TestField(Blocked, false);
            Description := Item.Description;
            "Description 2" := Item."Description 2";

            if Item."Purch. Unit of Measure" <> '' then
                "Unit of Measure Code" := Item."Purch. Unit of Measure"
            else
                "Unit of Measure Code" := Item."Base Unit of Measure";
        end;
    end;

    procedure GetResource(): Record Resource
    var
        Resource: Record Resource;
    begin
        TestField("No.");
        Resource.Get("No.");
        exit(Resource);
    end;

    local procedure GetResource(var Resource: Record Resource)
    begin
        TestField("No.");
        Resource.Get("No.")
    end;

    local procedure CopyFromResource()
    var
        Resource: Record Resource;
    begin
        GetResource(Resource);
        Resource.CheckResourcePrivacyBlocked(false);
        Resource.TestField(Blocked, false);
        Resource.TestField("Gen. Prod. Posting Group");
        Description := Resource.Name;
        "Description 2" := Resource."Name 2";
        "Unit of Measure Code" := Resource."Base Unit of Measure";
    end;

    local procedure CopyFromFixedAsset()
    var
        FixedAsset: Record "Fixed Asset";
    begin
        FixedAsset.Get("No.");
        FixedAsset.TestField(Blocked, false);
        Description := FixedAsset.Description;
        "Description 2" := FixedAsset."Description 2";
    end;
}