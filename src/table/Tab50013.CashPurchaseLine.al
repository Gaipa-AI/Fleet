table 50013 "Cash Purchase Line"
{
    Caption = 'Cash Purchase Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; Type; Option)
        {
            OptionMembers = " ","G/L Account",Item,"Fixed Asset";
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = If ("Type" = const("G/L Account")) "G/L Account" where("Direct Posting" = const(true), "Account Type" = const(Posting))
            else
            If (Type = const("Fixed Asset")) "Fixed Asset" where(Blocked = filter(false));

            trigger OnLookup()
            var
                GLAcc: Record "G/L Account";
                ItemRec: Record Item;
                FixedAsset: Record "Fixed Asset";
            begin
                case Type of
                    Type::"G/L Account":
                        begin
                            GLAcc.SetRange("Account Type", GLAcc."Account Type"::Posting);
                            GLAcc.SetRange("Direct Posting", true);
                            GLAcc.SetRange(Blocked, false);
                            GLAcc.SetRange("Income/Balance", GLAcc."Income/Balance"::"Income Statement");
                            if Page.RunModal(16, GLAcc) = Action::LookupOK then;
                            "No." := GLAcc."No.";
                            Description := GLAcc.Name;
                        end;
                    Type::Item:
                        begin
                            Description := '';
                            "Shortcut Dimension 1 Code" := '';
                            "Shortcut Dimension 2 Code" := '';
                            ItemRec.Reset;
                            ItemRec.SetFilter(Blocked, '%1', false);
                            ItemRec.SetFilter("Inventory Posting Group", InventoryPostingFilter());
                            // Use the "Location Code" from the current line instead of the header
                            if Rec."Location" = '' then Error('Please enter a Location Code before selecting Items');
                            ItemRec.SetFilter("Location Filter", "Location");
                            if Page.RunModal(31, ItemRec) = Action::LookupOK then begin
                                "No." := ItemRec."No.";
                            end;
                            Description := ItemRec.Description;
                            "Item Category Code" := ItemRec."Item Category Code";
                            "Unit Cost" := ItemRec."Unit Cost";
                            "Unit of Measure Code" := ItemRec."Base Unit of Measure";
                            "Shortcut Dimension 1 Code" := ItemRec."Global Dimension 1 Code";
                            "Shortcut Dimension 2 Code" := ItemRec."Global Dimension 2 Code";
                        end;
                    Type::"Fixed Asset":
                        begin
                            FixedAsset.SetRange(Blocked, false);
                            if Page.RunModal(5601, FixedAsset) = Action::LookupOK then;
                            "No." := FixedAsset."No.";
                            Description := FixedAsset.Description;
                        end;
                end;
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            //Editable = false;
        }
        field(6; Location; Code[20])
        {
            Caption = 'Location';
            TableRelation = Location;
        }
        field(7; Inventory; Decimal)
        {
            Caption = 'Inventory';
            Editable = false;

            trigger OnValidate()
            begin
            end;
        }
        field(8; "Unit of Measure Code"; Code[20])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));
        }
        field(9; Quantity; Decimal)
{
    Caption = 'Quantity';

    trigger OnValidate()
    var
        ItemUOMRec: Record "Item Unit of Measure";
        ConversionFactorRequested: Decimal; // Conversion factor for Requested UOM
        RequestedQtyBase: Decimal; // Stores the requested quantity in base unit
    begin
        if "No." = '' then
            exit;

        if "Type" = "Type"::"G/L Account" then begin
            // If type is G/L Account, calculate the amount using Quantity
            Amount := Quantity * "Unit Cost";
        end else begin
            // Proceed with the conversion if type is either Item or Fixed Asset
            if "PUOM" <> '' then begin
                // Get the conversion factor for the Requested UOM (e.g., BOX)
                ItemUOMRec.Reset();
                ItemUOMRec.SetRange("Item No.", "No.");
                ItemUOMRec.SetRange(Code, "PUOM");

                if ItemUOMRec.FindFirst() then begin
                    ConversionFactorRequested := ItemUOMRec."Qty. per Unit of Measure";
                    if ConversionFactorRequested = 0 then
                        Error('Conversion factor for Requested UOM "%1" is invalid.', "PUOM");

                    // Convert the required quantity to base unit
                    RequestedQtyBase := Round(Quantity * ConversionFactorRequested, 0.01);

                    // Set the converted quantity to the Quote Qty field
                    "Quote Qty" := RequestedQtyBase;

                    // Calculate the amount using the Quote Qty
                    Amount := CalculateLineAmount("Quote Qty", "Unit Cost");

                end else
                    Error('Requested Unit of Measure "%1" is not set up for item "%2".', "PUOM", "No.");
            end;
        end;
    end;
}

        
        field(10; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';

            trigger OnValidate()
            begin
                if "Type" = "Type"::"G/L Account" then begin
                    // If type is G/L Account, calculate the amount using Quantity
                    Amount := Quantity * "Unit Cost";
                end else
                    if ("Type" = "Type"::Item) or ("Type" = "Type"::"Fixed Asset") then begin
                        // If type is Item or Fixed Asset, calculate the amount using Quote Qty
                        Amount := "Quote Qty" * "Unit Cost";
                    end else begin
                        // Default case if needed
                        Amount := 0;
                    end;
            end;

        }
        field(11; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,1,1';
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,1,2';
        }
        field(14; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
        }
        field(15; "Gen. Product Posting Group"; Code[20])
        {
            Caption = 'Gen. Product Posting Group';
        }
        field(16; "Gen. Journal Batch"; Code[20])
        {
            Caption = 'Gen. Journal Batch';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = filter('PAYMENTS'));

            trigger OnValidate()
            begin
                Rec.TestField(Type, Rec.Type::"G/L Account");
            end;
        }
        field(17; Posted; Boolean)
        {
            Caption = 'Posted';
            Editable = false;

            trigger OnValidate()
            begin
                "Posted By" := UserId;
                "Date Posted" := Today;
                "Time Posted" := Time;
            end;
        }
        field(18; "Posted By"; Code[50])
        {
            Caption = 'Posted By';
            Editable = false;
        }
        field(19; "Date Posted"; Date)
        {
            Caption = 'Date Posted';
            Editable = false;
        }
        field(20; "Time Posted"; Time)
        {
            Caption = 'Time Posted';
            Editable = false;
        }
        field(21; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = true;
        }
        field(22; "Buy-From-Vendor-No."; Code[20])
        {
            Caption = 'Buy-From-Vendor-No.';
            TableRelation = Vendor where(Blocked = filter(" " | Payment));

            trigger OnValidate()
            begin
                if not (Rec.Type in [Rec.Type::Item, Rec.Type::"Fixed Asset"]) then Error('Type cannot be g/l account');
            end;
        }
        field(23; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(24; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(25; Selection; Boolean)
        {
        }
        field(26; "Item Category Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Item Category";
        }
        field(27; "Recipient Code"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Quote Qty"; Decimal)
        {

        }
         field(29; "PUOM"; Code[20])
{
    Caption = 'Purch.Unit of Measure Code';
    TableRelation = "Item Unit of Measure".Code where("Item No." = field("No."));
    trigger OnValidate()
    var
        ItemUOMRec: Record "Item Unit of Measure";
        ConversionFactorRequested: Decimal; // Conversion factor for Requested UOM
        RequestedQtyBase: Decimal; // Stores the requested quantity in base unit
    begin
        if "No." = '' then
            exit;

        if "Type" = "Type"::"G/L Account" then begin
            // If type is G/L Account, calculate the amount using Quantity
            Amount := Quantity * "Unit Cost";
        end else begin
            // Proceed with the conversion if type is either Item or Fixed Asset
            if "Unit of Measure Code" <> '' then begin
                // Get the conversion factor for the Requested UOM (e.g., BOX)
                ItemUOMRec.Reset();
                ItemUOMRec.SetRange("Item No.", "No.");
                ItemUOMRec.SetRange(Code, "Unit of Measure Code");

                if ItemUOMRec.FindFirst() then begin
                    ConversionFactorRequested := ItemUOMRec."Qty. per Unit of Measure";
                    if ConversionFactorRequested = 0 then
                        Error('Conversion factor for Requested UOM "%1" is invalid.', "Unit of Measure Code");

                    // Convert the required quantity to base unit
                    RequestedQtyBase := Round(Quantity * ConversionFactorRequested, 0.01);

                    // Set the converted quantity to the Quote Qty field
                    "Quote Qty" := RequestedQtyBase;

                    // Calculate the amount using the Quote Qty
                    Amount := CalculateLineAmount("Quote Qty", "Unit Cost");

                end else
                    Error('Requested Unit of Measure "%1" is not set up for item "%2".', "Unit of Measure Code", "No.");
            end;
        end;
    end;
}
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    // trigger OnInsert()
    // begin
    //     "Shortcut Dimension 1 Code" := UserSetup.DefaultAreaCode();
    //     "Shortcut Dimension 3 Code" := UserSetup.DefaultDepartmentCode();
    // end;

    trigger OnDelete()
    begin
        Rec.TestField(Posted, false);
    end;

    trigger OnModify()
    begin
        Rec.TestField(Posted, false);
    end;

    procedure InventoryPostingFilter(): Text
    var
        CashPurchase: Record "Cash Purchase";
    begin
        if CashPurchase.Get(Rec."Document No.") then begin
            exit(CashPurchase."Inventory Posting Group Filter");
        end;
    end;

    local procedure CalculateLineAmount(QuoteQty: Decimal; UnitCost: Decimal): Decimal
    begin
        Amount := 0;

        if "Type" = "Type"::Item then begin
            Amount := QuoteQty * UnitCost;
        end else
            if "Type" = "Type"::"Fixed Asset" then begin
                // Perform calculation for fixed assets if needed
                Amount := QuoteQty * UnitCost; // Adjust if calculation differs
            end else
                if "Type" = "Type"::"G/L Account" then begin
                    // Use Quantity for G/L Account
                    Amount := Quantity * UnitCost;
                end;

        exit(Amount);
    end;


    var
        UserSetup: Record "User Setup";
}
