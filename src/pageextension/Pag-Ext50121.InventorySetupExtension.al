pageextension 50121 "Inventory Setup Extension" extends "Inventory Setup"
{
    layout{
        addafter("Package Nos.")
        {
            field("Spare Transfer Template"; Rec."Spare Transfer Template")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the spare transfer template to be used for spare part transfer.';
            }
            field("Spare Transfer Batch"; Rec."Spare Transfer Batch")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the spare transfer batch to be used for spare part transfer.';
            }
            field("Cash Purchase Nos"; Rec."Cash Purchase Nos")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number series to be used for cash purchase journal.';
            }
            
    }
}
}